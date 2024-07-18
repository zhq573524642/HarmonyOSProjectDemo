
@Entry
@Component
struct ListHorizontalPage {
  @State dataList: Array<string> = []
  private scroller: Scroller = new Scroller()
  private scroller1: Scroller = new Scroller()
  private images: Resource[] = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3'),]

  aboutToAppear(): void {
    for (let i = 0; i < 20; i++) {
      this.dataList.push('Item-' + i)
    }
  }

  build() {
    Column() {
      List({ scroller: this.scroller, space: 10 }) {
        ForEach(this.dataList, (item: string, index: number) => {
          ListItem() {
            Column() {
              Image(this.images[index%this.images.length])
                .borderRadius({
                  topLeft: 12,
                  topRight: 12,
                  bottomLeft: 0,
                  bottomRight: 0
                })
                .objectFit(ImageFit.Cover)
                .width('100%')
                .height(60)
              Text(`${item}`).fontSize(15).fontColor(Color.Black).margin(10)
              Text(`subTitle-${index}`).fontSize(13).fontColor(Color.Gray).margin({ left: 10, bottom: 10 })
            }.width(100)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .alignItems(HorizontalAlign.Start)
          }
        }, (item: string) => item)
      }.width('100%')
      .height(250)
      .listDirection(Axis.Horizontal)

      List({ scroller: this.scroller1, space: 15 }) {
        ForEach(this.dataList, (item: string, index: number) => {
          ListItem() {
            Column() {
              Image(this.images[index%this.images.length])
                .borderRadius(12)
                .objectFit(ImageFit.Cover)
                .width('80%')
                .height(160)
            }
            .borderRadius(12)
            .alignItems(HorizontalAlign.Start)
          }
        }, (item: string) => item)
      }.width('100%')
      .height(250)
      .scrollSnapAlign(ScrollSnapAlign.CENTER)
      .listDirection(Axis.Horizontal)
    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}