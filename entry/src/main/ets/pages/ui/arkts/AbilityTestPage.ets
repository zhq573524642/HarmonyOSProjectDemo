import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { common, Want } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { promptAction, router } from '@kit.ArkUI'
import { data } from '@kit.TelephonyKit'

@Entry
@Component
struct AbilityTestPage {
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext
  @State params: number = 0
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: 'UIAbility生命周期' })
          .onClick(() => {

          })

        CommonButton({ text: '获取UIAbility信息' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkts/UIAbilityInfoPage'
            })
          })

        CommonTitle({ title: 'UIAbility间跳转交互' })
        CommonTitle({ title: '1.跳转应用内其他UIAbility' })
        CommonButton({ text: '显式跳转应用内的其他UIAbility' })
          .onClick(() => {
            this.params++
            let want: Want = {
              deviceId: '', //为空代表本设备
              bundleName: 'com.zhq.harmonyosdemo', //当前应用的包名
              abilityName: 'MyFeatureLibAbility', //跳转目标的AbilityName(显示启动必填)
              moduleName: 'myFeatureLib', //module名称
              uri: 'https://www.baidu.com',
              parameters: {
                param_info: this.params + ''
              },
              type: '什么type'
            }
            this.context.startAbility(want).then(() => {
              console.debug('===跳转成功')
            }).catch((error: BusinessError) => {
              console.debug('===跳转失败:' + error.message)
            })
          })

        CommonButton({ text: '显式跳转应用内的其他UIAbility并携带数据返回' })
          .onClick(() => {
            this.params++
            let want: Want = {
              deviceId: '', //为空代表本设备
              bundleName: 'com.zhq.harmonyosdemo',
              abilityName: 'MyFeatureLibAbility',
              moduleName: 'myFeatureLib',
              parameters: {
                param_info: this.params + ''
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
        CommonTitle({ title: '2.跳转应用内其他UIAbility的指定的页面' })
        CommonButton({ text: '目标UIAbility的页面冷启动' })
          .onClick(() => {
            let want: Want = {
              deviceId: '', //为空代表本设备
              bundleName: 'com.zhq.harmonyosdemo', //当前应用的包名
              abilityName: 'MyFeatureLibAbility', //跳转目标的AbilityName(显示启动必填)
              moduleName: 'myFeatureLib', //module名称
              uri: 'https://www.baidu.com',
              parameters: {
                page_router:'secondPage'
              },
              type: '什么type'
            }
            this.context.startAbility(want).then(() => {
              console.debug('===跳转成功')
            }).catch((error: BusinessError) => {
              console.debug('===跳转失败:' + error.message)
            })
          })
        CommonButton({ text: '目标UIAbility的页面热启动' })
          .onClick(() => {
            let want: Want = {
              deviceId: '', //为空代表本设备
              bundleName: 'com.zhq.harmonyosdemo', //当前应用的包名
              abilityName: 'MyFeatureLibAbility', //跳转目标的AbilityName(显示启动必填)
              moduleName: 'myFeatureLib', //module名称
              uri: 'https://www.baidu.com',
              parameters: {
                page_router:'thirdPage'
              },
              type: '什么type'
            }
            this.context.startAbility(want).then(() => {
              console.debug('===跳转成功')
            }).catch((error: BusinessError) => {
              console.debug('===跳转失败:' + error.message)
            })
          })

        CommonButton({ text: '显式跳转其他应用UIAbility（Entry）' })
          .onClick(() => {
            let want: Want = {
              bundleName: 'com.zhq.harmonytrain',
              moduleName: 'entry',
              abilityName: 'EntryAbility',
              parameters: {
                param_info: '显式跳转EntryAbility传参：AAA'
              }
            }
            this.context.startAbility(want, (error) => {
              console.debug('===跳转错误：' + error?.code)
            })
          })

        CommonButton({ text: '显式跳转其他应用UIAbility（Feature）' })
          .onClick(() => {
            let want: Want = {
              bundleName: 'com.zhq.harmonytrain',
              moduleName: 'TestModule',
              abilityName: 'TestModuleAbility',
              parameters: {
                param_info: '显式跳转TestModuleAbility传参：BBB'
              }
            }
            this.context.startAbility(want, (error) => {
              console.debug('===跳转错误：' + error?.code)
            })
          })

        CommonButton({ text: '隐式跳转其他应用UIAbility（Entry）' })
          .onClick(() => {
            let want: Want = {
              parameters: {
                param_info: '隐式跳转EntryAbility传参：CCC'
              },
              action: 'ohos.want.action.viewData',
              entities: ['entity.system.default']
            }

            this.context.startAbility(want, (error) => {
              console.debug('===跳转错误：' + error?.code)
            })
          })
        CommonButton({ text: '隐式跳转其他应用UIAbility（Feature）' })
          .onClick(() => {
            let want: Want = {
              parameters: {
                param_info: '隐式跳转TestModuleAbility传参：DDD'
              },
              action: 'com.zhq.viewAction',
              entities: ['com.zhq.viewData']
            }

            this.context.startAbility(want, (error) => {
              console.debug('===跳转错误：' + error?.code)
            })
          })
        //DOTO 目标Ability的module.json配置
        //"skills": [
        //           {
        //             "entities": [
        //               "entity.system.home",
        //               "entity.system.default"
        //             ],
        //             "actions": [
        //               "action.system.home",
        //               "ohos.want.action.viewData",
        //               "ohos.want.action.editData"
        //             ]
        //           }
        //         ]

        CommonButton({ text: '显式跳转其他应用UIAbility并回传参数（Entry）' })
          .onClick(() => {
            let want: Want = {
              bundleName: 'com.zhq.harmonytrain',
              moduleName: 'entry',
              abilityName: 'EntryAbility',
              parameters: {
                param_info: '显式跳转EntryAbility传参：EEE'
              }
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
        CommonButton({ text: '显式跳转其他应用UIAbility并回传参数（Feature）' })
          .onClick(() => {
            let want: Want = {
              bundleName: 'com.zhq.harmonytrain',
              moduleName: 'TestModule',
              abilityName: 'TestModuleAbility',
              parameters: {
                param_info: '显式跳转TestModuleAbility传参：FFF'
              }
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
        CommonButton({ text: '隐式跳转其他应用UIAbility并回传参数（Entry）' })
          .onClick(() => {
            let want: Want = {
              parameters: {
                param_info: '隐式跳转EntryAbility传参：GGG'
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
        CommonButton({ text: '隐式跳转其他应用UIAbility并回传参数（Feature）' })
          .onClick(() => {
            let want: Want = {
              parameters: {
                param_info: '隐式跳转TestModuleAbility传参：HHH'
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
            let want: Want = {
              parameters: {
                targetRouter: 'start_func_page'
              },
              action: 'ohos.want.action.viewData',
              entities: ['entity.system.default']
            }
            this.context.startAbility(want)
          })
        CommonButton({ text: '跳转其他应用内页面（热启动）' })
          .onClick(() => {
            let want: Want = {
              parameters: {
                targetRouter: 'start_func_page'
              },
              action: 'ohos.want.action.viewData',
              entities: ['entity.system.default']
            }
            this.context.startAbility(want)
          })

        CommonButton({ text: '隐式打开应用' })
          .onClick(() => {
            let wantInfo: Want = {
              // uncomment line below if wish to implicitly query only in the specific bundle.
              // bundleName: 'com.example.myapplication',
              action: 'ohos.want.action.viewData',
              // entities can be omitted
              entities: ['entity.system.browsable'],
              uri: 'https://www.baidu.com',
              type: 'text/plain',
            };
            this.context.startAbility(wantInfo)
          })
      }.width('100%')
    }.width('100%')
  }
}