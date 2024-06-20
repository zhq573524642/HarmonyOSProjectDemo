@Entry
@Component
struct SizeTestPage {
  build() {
    Column() {
      Column() {

      }
      .height('100%')
      .width('100%')
      .backgroundColor(Color.Red)
      .padding(10)
    }.width('100%')
    .backgroundColor(Color.Yellow)
    .height('100%')
  }
}