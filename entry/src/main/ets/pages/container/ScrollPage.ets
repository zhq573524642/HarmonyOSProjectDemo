import router from '@ohos.router'

@Entry
@Component
struct ScrollPage {
  scroller: Scroller = new Scroller()
  private num: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  private params: object = router.getParams()

  build() {
    Scroll(this.scroller) {
      if (this.params?.['direction'] == 1) {
        Column() {
          ForEach(this.num, (item: string) => {
            Text(item.toString())
              .width('90%')
              .height(150)
              .borderRadius(15)
              .fontColor(Color.Red)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.White)
              .margin({ top: 10 })
          }, (item: string) => item)
        }.width('100%')
      } else {
        Row() {
          ForEach(this.num, (item:string) => {
            Text(item.toString())
              .width(150)
              .height('90%')
              .borderRadius(15)
              .fontColor(Color.Red)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.White)
              .margin({ left: 10 })
          }, (item:string) => item)
        }.height('100%')
      }

    }
    .backgroundColor('#dcdcdc')
    .scrollable(this.params?.['direction'] == 1 ? ScrollDirection.Vertical : ScrollDirection.Horizontal) //滚动方向
    .scrollBarColor(Color.Red) //scrollBar颜色
    .scrollBarWidth(10) //scrollBar宽度
    .scrollBar(BarState.On) //scrollBar是否一直显示
    .edgeEffect(EdgeEffect.Spring) //滚动到边缘后回弹
  }
}