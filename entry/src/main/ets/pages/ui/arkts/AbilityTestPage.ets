import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { common, Want } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { promptAction } from '@kit.ArkUI'
import { data } from '@kit.TelephonyKit'

@Entry
@Component
struct AbilityTestPage {
  private context = getContext(this) as common.UIAbilityContext

  build() {
    Column() {
      CommonButton({ text: 'UIAbility生命周期' })
        .onClick(() => {

        })

      CommonTitle({ title: 'UIAbility与UI的数据同步：EventHub' })
      CommonButton({ text: '发送EventHub事件' })
        .onClick(() => {

          // this.context.eventHub.emit('event_1')
          // this.context.eventHub.emit('event_1', '哈哈哈')
          this.context.eventHub.emit('event_1', '啦啦啦', 18)
        })
      CommonButton({ text: '取消订阅EventHub事件' })
        .onClick(() => {
          this.context.eventHub.off('event_1')
        })
      CommonTitle({ title: 'UIAbility间跳转交互' })
      CommonButton({ text: '跳转应用内的其他UIAbility' })
        .onClick(() => {
          let want: Want = {
            deviceId: '', //为空代表本设备
            bundleName: 'com.example.myapplication',
            abilityName: 'MyFeatureLibAbility',
            moduleName: 'myFeatureLib',
            parameters: {
              param_info: '这是传过来的参数'
            }
          }
          this.context.startAbility(want).then(() => {
            console.debug('===跳转成功')
          }).catch((error: BusinessError) => {
            console.debug('===跳转失败:' + error.message)
          })
        })

      CommonButton({ text: '跳转应用内的其他UIAbility并携带数据返回' })
        .onClick(() => {
          let want: Want = {
            deviceId: '', //为空代表本设备
            bundleName: 'com.example.myapplication',
            abilityName: 'MyFeatureLibAbility',
            moduleName: 'myFeatureLib',
            parameters: {
              param_info: '这是传过来的参数'
            }
          }
          this.context.startAbilityForResult(want).then((data) => {
            if (data?.resultCode === 1001) {
              let info = data?.want?.parameters?.param_info
              if (info != null) {
                setTimeout(() => {
                  promptAction.showToast({ message: JSON.stringify(info) })
                }, 500)
              }
            }
            console.debug('===跳转成功')
          }).catch((error: BusinessError) => {
            console.debug('===跳转失败:' + error.message)
          })
        })

      CommonButton({ text: '跳转其他应用UIAbility' })
        .onClick(() => {
          let want: Want = {
            parameters: {
              param_info: '哈哈哈哈哈哈哈哈哈哈'
            },
            action: 'ohos.want.action.viewData',
            entities: ['entity.system.default']
          }

          this.context.startAbility(want, (error) => {
            console.debug('===跳转错误：' + error?.code)
          })
        })

      CommonButton({ text: '跳转其他应用UIAbility并回传参数' })
        .onClick(() => {
          let want: Want = {
            parameters: {
              param_info: '啊啊啊啊啊啊啊啊啊啊顶顶顶顶顶顶顶顶'
            },
            action: 'ohos.want.action.editData'
          }

          this.context.startAbilityForResult(want).then((data) => {
            if (data?.resultCode === 1001) {
              let info = data?.want?.parameters?.param_info
              setTimeout(() => {
                promptAction.showToast({ message: JSON.stringify(info) })
              }, 500)
            }
          })
        })
      CommonButton({ text: '跳转其他应用内页面（冷启动）' })
        .onClick(() => {
          let want:Want={
            parameters:{
              targetRouter:'start_func_page'
            },
            action: 'ohos.want.action.viewData',
            entities: ['entity.system.default']
          }
          this.context.startAbility(want)
        })
      CommonButton({ text: '跳转其他应用内页面（热启动）' })
        .onClick(() => {
          let want:Want={
            parameters:{
              targetRouter:'start_func_page'
            },
            action: 'ohos.want.action.viewData',
            entities: ['entity.system.default']
          }
          this.context.startAbility(want)
        })
    }.width('100%')
  }
}