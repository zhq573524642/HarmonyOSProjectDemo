@Entry
@Component
struct StudyView {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      //设置容器宽高
      //不设置时默认是宽/高包裹
      .width('100%') //宽
      .height('100%') //高
      //设置容器背景色
      // .backgroundColor(Color.Red)
      .backgroundColor('#ff00ff')
      //设置子View的位置
      // .alignItems(HorizontalAlign.Start)
      // .alignItems(HorizontalAlign.Center)
      // .alignItems(HorizontalAlign.End)
      // .justifyContent(FlexAlign.Start)
      // .justifyContent(FlexAlign.Center)
      // .justifyContent(FlexAlign.End)
      // .justifyContent(FlexAlign.SpaceAround)
      // .justifyContent(FlexAlign.SpaceBetween)
      // .justifyContent(FlexAlign.SpaceEvenly)
      // .responseRegion()
    }
    .width('100%')
    .height('100%')
  }
}