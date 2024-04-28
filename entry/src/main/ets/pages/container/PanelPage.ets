import { CommonButton } from '../component/MyComponent'

@Entry
@Component
struct PanelPage {
  @State isShow: boolean = false

  build() {
    Column() {
      CommonButton({ text: '点击' })
        .onClick(() => {
          this.isShow = !this.isShow
        })
      Panel(this.isShow) {
        Text().fontColor(Color.Black).fontSize(30).margin(20)
      }.width('100%')
      .type(PanelType.Minibar)
      .mode(PanelMode.Mini)
      .dragBar(true)
      .miniHeight(50)
      .show(this.isShow)
    }.width('100%')
    .height('100%')
  }
}