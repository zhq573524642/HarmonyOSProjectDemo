@Component
export struct CommonButton {
  private text: string

  build() {
    Row() {
      Button() {
        Text(this.text)
          .fontColor(Color.Black)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .padding(8)
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.Orange)
    }.margin(8)

  }
}

@Component
export struct CommonButton1 {
  @Link private text: string

  build() {
    Row() {
      Button() {
        Text(this.text)
          .fontColor(Color.Black)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .padding(8)
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.Orange)
    }.margin(8)

  }
}

@Component
export struct Square {

  /**
   * In low-code mode, do not add anything to the build function, as it will be
   * overwritten by the content generated by the .visual file in the build phase.
   */
  private text: string
  private color: Color
  private w:number
  private h:number

  build() {
    Text(this.text)
      .fontColor(Color.Black)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .padding(10)
      .backgroundColor(this.color)
      .width(this.w)
      .height(this.h)
  }
}

@Component
export struct CommonTitle {
  private title: string

  build() {
    Row() {
      Text(this.title)
        .fontColor(Color.Black)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
    }.padding(15)
  }
}