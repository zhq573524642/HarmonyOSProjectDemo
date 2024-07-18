import { CommonButton } from '../component/MyComponent'
import { abilityAccessCtrl, bundleManager, common, Permissions, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct PermissionsPage {
  permissions: Array<Permissions> = ['ohos.permission.CAMERA', 'ohos.permission.MICROPHONE'];
  permission: Permissions = 'ohos.permission.CAMERA'

  build() {
    Column() {
      CommonButton({ text: '单个权限申请：申请相机权限' })
        .onClick(() => {
          this.checkOnePermissions(this.permission, (grantStatus: abilityAccessCtrl.GrantStatus, isAgree: boolean) => {
            if (isAgree) {
              promptAction.showToast({ message: '已存在权限，执行业务逻辑' })
            } else {
              const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
              this.reqPermissionFromUser(context, this.permission, (isAgree: boolean) => {
                if (isAgree) {
                  promptAction.showToast({ message: '同意权限，执行业务逻辑' })
                } else {
                  promptAction.showToast({ message: '拒绝权限，提示去设置自行操作' })
                  this.openPermissionsInSystemSettings(context)
                }
              })
            }
          })
        })
      CommonButton({ text: '多个权限申请：申请相机权限和麦克风权限' })
        .onClick(() => {
          this.checkPermissions(this.permissions, (isAllAgree: boolean) => {
            if (isAllAgree) {
              promptAction.showToast({ message: '已存在权限，执行业务逻辑' })
            } else {
              const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
              this.reqPermissionsFromUser(context, this.permissions, (isAgree: boolean) => {
                if (isAgree) {
                  promptAction.showToast({ message: '同意权限，执行业务逻辑' })
                } else {
                  promptAction.showToast({ message: '拒绝权限，提示去设置自行操作' })
                }
              })
            }
          })
        })
    }
    .width('100%')
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

  async checkOnePermissions(permission: Permissions, callback?: Function): Promise<void> {
    let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkPermissionGrant(permission);
    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
      if (callback) {
        callback(grantStatus, true)
      }
    } else {
      // 申请权限
      if (callback) {
        callback(grantStatus, false)
      }
    }
  }

  async checkPermissions(permissions: Array<Permissions>, callback?: Function): Promise<void> {

    let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkPermissionGrant(permissions[0]);
    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
      if (callback) {
        callback(true)
      }
    } else {
      // 申请权限
      if (callback) {
        callback(false)
      }
    }
  }

  // 使用UIExtensionAbility：将common.UIAbilityContext 替换为common.UIExtensionContext
  reqPermissionsFromUser(context: common.UIAbilityContext, permissions: Array<Permissions>,
    callback?: Function): void {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      let agreeCount: number = 0
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
          console.debug('===用户同意权限，权限申请成功')
          agreeCount += 1
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          console.debug('===用户拒绝权限，权限申请失败')
          return;
        }
      }
      if (agreeCount == length) {
        callback?.(true)
      } else {
        callback?.(false)
      }
      // 授权成功
    }).catch((err: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })
  }

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

  openPermissionsInSystemSettings(context: common.UIAbilityContext): void {
    let wantInfo: Want = {
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      uri: 'application_info_entry',
      parameters: {
        pushParams: 'com.example.myapplication' // 打开指定应用的详情页面
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
}