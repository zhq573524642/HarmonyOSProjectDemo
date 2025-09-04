import { CommonButton } from '../component/MyComponent'
import { AbilityConstant, common } from '@kit.AbilityKit'
import { RouterUtil } from '@ohos/common'

@Entry({routeName:"AppContinuePage"})
@Component
export  struct AppContinuePage {
  uiContext = getContext(this) as common.UIAbilityContext
  @State inputText: string = ''
  @State cursorIndex: number = 0

  static startPage(params: Record<string, Object>) {
    RouterUtil.pushNamedRoute('AppContinuePage', params)
  }

  aboutToAppear(): void {
    let params = RouterUtil.getParams() as Record<string, Object>
    this.inputText = params['get_continue_content'] as string
  }

  build() {
    Column() {
      CommonButton({ text: '开启应用接续' })
        .onClick(() => {
          this.uiContext.setMissionContinueState(AbilityConstant.ContinueState.ACTIVE, (result) => {
            console.debug('===设置开启应用接续：' + JSON.stringify(result))
          })
        })
      TextInput({
        text: this.inputText
      })
        .onChange((value) => {
          this.inputText = value
          AppStorage.setOrCreate("app_continue_content", value)
        })
        .height(50)

    }.width('100%')
  }
}