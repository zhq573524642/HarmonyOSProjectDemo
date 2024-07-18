import { CommonTitle } from './MyComponent'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct TextInputPage {
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '输入框' })
        TextInput({ placeholder: '请输入账号' })
          .type(InputType.Number)
          .enterKeyType(EnterKeyType.Next)
          .backgroundColor(Color.Pink)
          .width(200)
          .height(50)
          .margin({ left: 15, right: 15 })
          .onChange((value: string) => {

          })
          .onFocus(() => {

          })
        TextInput({ placeholder: '请输入密码' })
          .type(InputType.Password)
          .enterKeyType(EnterKeyType.Go)
          .backgroundColor(Color.Pink)
          .width(200)
          .height(50)
          .margin({ top: 15, left: 15, right: 15 })
          .onSubmit((enterKey: EnterKeyType) => {
            promptAction.showToast({ message: enterKey + '' })
          })

        CommonTitle({ title: '搜索组件-Search' })
        Search({ placeholder: '请输入搜索的内容' })
          .searchButton('搜索')
          .placeholderColor(Color.Gray)
          .placeholderFont({ style: FontStyle.Normal, size: 14, weight: 500 })
          .textAlign(TextAlign.Center)
          .textFont({ size: 14, style: FontStyle.Italic, weight: 500 })
          .backgroundColor('#f5f5f5')
          .width('90%')
          .onSubmit((content: string) => {
            promptAction.showToast({ message: content })
          })
          .copyOption(CopyOptions.InApp)
          .onChange((content: string) => {

          })
          .onCopy((content: string) => {

          })
          .onCut((content: string) => {

          })
          .onPaste((content: string) => {

          })
      }.width('100%')
    }
    .width('100%')
  }
}