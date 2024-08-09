import Want from '@ohos.app.ability.Want';
import { common, ErrorCode } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State message: string = '这是一个FeatureLibrary';
  @State info: string = ''
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext

  aboutToAppear(): void {
    let want = AppStorage.get<Want>('startAbilityInfo')
    this.info = `信息：\n bundleName:${want?.bundleName}
     \n abilityName:${want?.abilityName}
     \n deviceId:${want?.deviceId}
     \n moduleName:${want?.moduleName}
     \n 自定义参数:${want?.parameters?.param_info}`
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text(this.info)
          .fontSize(20)
          .margin(10)
          .fontWeight(FontWeight.Bold)
        Button('停止当前UIAbility')
          .onClick(() => {
            this.context.terminateSelf((error) => {
              if (error.code) {
                console.debug('===停止当前UIAbility：' + error.code)
              }
            })
          })

        Button('停止当前UIAbility并携带参数返回')
          .margin(10)
          .onClick(() => {
            let abilityDataResult:common.AbilityResult={
              resultCode:1001,
              want:{
                deviceId: '', //为空代表本设备
                bundleName: 'com.zhq.harmonyosdemo',
                abilityName: 'MyFeatureLibAbility',
                moduleName: 'myFeatureLib',
                parameters: {
                  param_info: '这是返回来的参数'
                }
              }
            }
            this.context.terminateSelfWithResult(abilityDataResult,(error) => {
              if (error.code) {
                console.debug('===停止当前UIAbility：' + error.code)
              }
            })
          })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(Color.Red)
  }
}