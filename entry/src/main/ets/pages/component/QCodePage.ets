@Entry
@Component
struct QCodePage {
  @State private inputContent: string = ''

  build() {

    Column() {
      TextInput({ placeholder: '请输入' })
        .width('100%')
        .margin(10)
        .height(50)
        .type(InputType.Normal)
        .onChange((value: string) => {
          this.inputContent = value
        })

      QRCode(this.inputContent)
        .color(Color.Pink)
        .backgroundColor(Color.Transparent)
        .width(200)
        .height(200)
    }
    .width('100%')
    .height('100%')
  }
}