import { abilityAccessCtrl, bundleManager, common, Permissions, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class PermissionUtils {
  private static instance: PermissionUtils

  public static getInstance(): PermissionUtils {
    if (!PermissionUtils.instance) {
      PermissionUtils.instance = new PermissionUtils()
    }
    return PermissionUtils.instance
  }

  //检测权限是否已经全部申请
  async checkPermissions(permissions: Array<Permissions>,
    callback?: (isAllGrant: boolean, deniedPermissions: Array<Permissions>) => void): Promise<void> {
    let grantCount: number = 0
    let deniedCount: number = 0
    let deniedPerArr: Array<Permissions> = []
    for (let permissionsElement of permissions) {
      let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkPermissionGrant(permissionsElement);
      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        // 已经授权，可以继续访问目标操作
        grantCount += 1
      } else {
        // 申请权限
        deniedCount += 1
        deniedPerArr.push(permissionsElement)
      }
    }
    if (callback) {
      callback(grantCount == permissions.length, deniedPerArr)
    }
  }

  //申请多个权限
  // 使用UIExtensionAbility：将common.UIAbilityContext 替换为common.UIExtensionContext
  reqPermissionsFromUser(context: common.UIAbilityContext, permissions: Array<Permissions>,
    callback?: (isAllGrant: boolean, deniedPermissions: Array<Permissions>) => void): void {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      let agreeCount: number = 0
      let deniedCount: number = 0
      let deniedPer: Array<Permissions> = []
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
          agreeCount += 1
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          deniedCount += 1
          deniedPer.push(permissions[i])
          return;
        }
      }
      if (agreeCount == length) {
        callback?.(true, deniedPer)
      } else {
        callback?.(false, deniedPer)
      }
      // 授权成功
    }).catch((err: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })
  }

  //申请单个权限
  reqPermissionFromUser(context: common.UIAbilityContext, permission: Permissions,
    callback?: Function): void {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, [permission]).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      if (grantStatus[0] === 0) {
        // 用户授权，可以继续访问目标操作
        console.debug('===用户同意权限，权限申请成功')
        if (callback) {
          callback(true)
        }
      } else {
        // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
        console.debug('===用户拒绝权限，权限申请失败')
        if (callback) {
          callback(false)
        }
        return;
      }
      // 授权成功
    }).catch((err: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })
  }

  //打开系统权限设置页面
  openPermissionsInSystemSettings(context: common.UIAbilityContext,bundleName:string): void {
    let wantInfo: Want = {
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      uri: 'application_info_entry',
      parameters: {
        pushParams: bundleName // 打开指定应用的详情页面
      }
    }
    context.startAbility(wantInfo).then(() => {
      // ...
      console.debug('===打开了')
    }).catch((err: BusinessError) => {
      // ...、
      console.debug('===错误了')
    })
  }

  private async checkPermissionGrant(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    // 获取应用程序的accessTokenID
    let tokenId: number = 0;
    try {
      let bundleInfo: bundleManager.BundleInfo =
        await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
    }

    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      const err: BusinessError = error as BusinessError;
      console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
    }

    return grantStatus;
  }
}