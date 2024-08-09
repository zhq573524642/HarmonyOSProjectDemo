@Entry
@Component
struct QCodePage {
  @State private inputContent: string = ''

  build() {

    Column() {
      TextInput({ placeholder: '请输入' })
        .width('90%')
        .margin(10)
        .height(50)
        .type(InputType.Normal)
        .onChange((value: string) => {
          this.inputContent = value
        })

      QRCode(this.inputContent)
        .color(Color.Pink)
        .backgroundColor(Color.Yellow)
        .width(200)
        .height(200)
    }
    .width('100%')
    .height('100%')
  }
}