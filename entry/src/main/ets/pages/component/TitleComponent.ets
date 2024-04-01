@Component
struct TitleComponent {
  build() {
    Row() {

    }
    .width('100%')
    .height(56)
    .backgroundColor(Color.Gray)
  }
}

@Component
export struct CircleView {
  @Link private bgColor: Color
  @Link private w: number
  @Link private h: number

  build() {
    Row() {
      Text('文本')
        .fontColor(Color.White)
        .fontSize(16)
    }
    .width(this.w)
    .height(this.h)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.bgColor)
    .borderStyle(BorderStyle.Solid)
    .borderColor(Color.Blue)
    .borderRadius(100)
    .borderWidth(5)

  }
}