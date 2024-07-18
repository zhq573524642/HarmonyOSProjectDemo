@Entry
@Component
struct ListSingleSelectPage {
  @State dataList: Array<string> = []
  private scroller: Scroller = new Scroller()
  private images: Resource[] = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3'),]
  @State selectedItem: string = ''

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
            Row() {
              Image(this.images[index%this.images.length]).margin(15).width(60).height(40).borderRadius(12)
              Text(item).fontSize(20).fontColor(Color.Black)
            }.alignItems(VerticalAlign.Center)
            .width('100%')
          }
          .margin({ left: 10, right: 10 })
          .backgroundColor(this.selectedItem === item ? Color.Pink : Color.White)
          .borderRadius(12)
          .onClick(() => {
            this.selectedItem = item
          })
        }, (item: string) => item)
      }.width('100%')

      .listDirection(Axis.Vertical)
    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}