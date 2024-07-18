
@Entry
@Component
struct ListItemDeletePage {
  @State dataList: Array<string> = []
  private scroller: Scroller = new Scroller()
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
            Row() {
              Image(this.images[index%this.images.length]).margin(15).width(60).height(40).borderRadius(12)
              Text(item).fontSize(20).fontColor(Color.Black)
            }.alignItems(VerticalAlign.Center)
            .width('100%')

          }
          .margin({ left: 10, right: 10 })
          .backgroundColor(Color.White)
          .borderRadius(12)
          .swipeAction({ end: this.itemDeleteEnd(index) })
        }, (item: string) => item)
      }.width('100%')
      .chainAnimation(true)//列表条目联动的动画
      .multiSelectable(true)
      .scrollSnapAlign(ScrollSnapAlign.END)
      .listDirection(Axis.Vertical)
    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }

  @Builder
  itemDeleteEnd(index: number) {
    Text('删除')
      .fontColor(Color.White)
      .fontSize(16)
      .width(80)
      .height(70)
      .borderRadius({topLeft:0,topRight:12,bottomLeft:0,bottomRight:12})
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Red)
      .onClick(() => {
        this.dataList.splice(index, 1)
      })
  }
}