import { Caller, common, Want } from '@kit.AbilityKit'
import { RouterUtil, ToastUtils } from '@ohos/common'
import { distributedDataObject } from '@kit.ArkData'
import distributedDeviceManager from '@ohos.distributedDeviceManager'
import { BusinessError } from '@kit.BasicServicesKit'
import { CommonButton } from '../component/MyComponent'


// 业务数据定义
class Data {
  title: string | undefined;
  text: string | undefined;

  constructor(title: string | undefined, text: string | undefined) {
    this.title = title;
    this.text = text;
  }
}

@Entry({ routeName: 'DistributedDataObject2Page' })
@Component
export struct DistributedDataObject2Page {
  private context = getContext(this) as common.UIAbilityContext
  caller: Caller | undefined
  sessionId: string = ''
  dataObject: distributedDataObject.DataObject | undefined

  static startPage() {
    RouterUtil.pushNamedRoute('DistributedDataObject2Page')
  }

  build() {
    Column() {
      CommonButton({ text: '拉起多端Ability' })
        .onClick(() => {
          this.handleCallRemote()
        })
      CommonButton({ text: '创建分布式对象数据设置sessionId加入组网' })
        .onClick(() => {
          this.createDataObject()
        })

    }.width('100%')
    .height('100%')
  }

  handleCallRemote() {
    if (this.caller) {
      ToastUtils.show('call remote already')
      return
    }
    //1.1 调用genSessionId接口创建一个sessionId，通过分布式设备管理接口获取对端设备networkId
    // this.sessionId = distributedDataObject.genSessionId()
    this.sessionId = '10676602'
    console.debug('===创建的sessionId：'+this.sessionId)
    let remoteDeviceId = this.getRemoteDeviceId()
    if (remoteDeviceId == '') {
      ToastUtils.show('未获取到远端设备Id')
      return
    }
    console.debug('===远端设备ID:' + remoteDeviceId)
    console.debug('===bundleName：' + this.context.applicationInfo.name)
    // 1.2 组装want，并将sessionId放入want
    let want: Want = {
      bundleName: this.context.applicationInfo.name,
      abilityName: 'EntryAbility',
      deviceId: remoteDeviceId,
      parameters: {
        // 'ohos.aafwk.param.callAbilityToForeground': true, // 前台启动，非必须
        'distributedSessionId': this.sessionId
      }
    }
    //1.3 调用startAbilityByCall接口拉起对端Ability
    try {
      this.context.startAbilityByCall(want).then((result: Caller) => {
        if (!result) {
          console.debug('===StartAbilityByCall Error')
        }
        this.caller = result
      })
        .catch((error: BusinessError) => {
          console.debug('===startAbility  error1:' + error.code + '--' + error.message)
        })
    } catch (e) {
      let error = e as BusinessError
      console.debug('===startAbility  error:' + error.code + '--' + error.message)
    }
  }

  // 2. 拉起对端Ability后创建分布式数据对象
  createDataObject() {
    if (!this.caller) {
      ToastUtils.show('call remote first')
      return;
    }
    if (this.dataObject) {
      ToastUtils.show('create dataObject already')
      return;
    }

    // 2.1 创建分布式数据对象实例
    let data = new Data('The title', 'The text');
    this.dataObject = distributedDataObject.create(this.context, data);

    // 2.2 注册数据变更监听
    this.dataObject.on('change', (sessionId: string, fields: Array<string>) => {
      fields.forEach((field) => {
        console.debug('===多端协同-发起端监听：sessionId:' + sessionId + '--' + field)
      });
    });
    // 2.3 设置同步sessionId加入组网
    this.dataObject.setSessionId(this.sessionId);
  }

  //获取可信网组中的设备
  getRemoteDeviceId() {
    let deviceId: string = ''
    let deviceManager = distributedDeviceManager.createDeviceManager(this.context.applicationInfo.name)
    let devices = deviceManager.getAvailableDeviceListSync()
    console.debug('===设备列表：'+devices.length)
    if (devices[0] && devices[0].networkId) {
      deviceId = devices[0].networkId
    }
    return deviceId
  }
}

