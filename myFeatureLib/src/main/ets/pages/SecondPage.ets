@Entry
@Component
struct SecondPage {
  @State message: string = '冷启动页面';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('SecondPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}