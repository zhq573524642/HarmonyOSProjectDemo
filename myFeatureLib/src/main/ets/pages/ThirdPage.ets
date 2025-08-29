@Entry
@Component
struct ThirdPage {
  @State message: string = '热启动页面';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('ThirdPageHelloWorld')
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