import thermal from '@ohos.thermal'

@Entry
@Component
struct GridPage {
  private scroller: Scroller = new Scroller()
  private gridData: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
    11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]

  build() {
    Column() {
      Row() {
        Button('上一页').onClick(() => {
          this.scroller.scrollPage({ next: false })
        })
        Button('下一页').onClick(() => {
          this.scroller.scrollPage({ next: true })
        })
      }.justifyContent(FlexAlign.SpaceEvenly).width('100%')

      Grid(this.scroller) {
        ForEach(this.gridData, (item: number, index) => {
          GridItem() {
            Text(item + '')
              .fontColor(Color.Black)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
          }
          .width(100)
          .height(100)
          .backgroundColor(Color.Gray)

        }, item => item)
      }
      // .maxCount(3)
      // .layoutDirection(GridDirection.Row)
      // .columnsTemplate('1fr 6fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .columnsGap(10)
      .margin(10)
      .height(250)
      .rowsGap(10)
    }.width('100%')
    .height('100%')
  }
}