@Entry
@Component
struct SwiperPage {
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      Swiper(this.swiperController) {
        Text('Item-1')
          .fontWeight(FontWeight.Lighter)
          .fontSize(30)
          .borderRadius(10)
          .width('90%')
          .height(100)
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.Red)
          .margin(3)
        Text('Item-2')
          .fontWeight(FontWeight.Lighter)
          .fontSize(30)
          .borderRadius(10)
          .width('90%')
          .height(100)
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.Pink)
          .margin(3)
        Text('Item-3')
          .fontWeight(FontWeight.Lighter)
          .fontSize(30)
          .borderRadius(10)
          .width('90%')
          .height(100)
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.Yellow)
          .margin(3)
        Text('Item-4')
          .fontWeight(FontWeight.Lighter)
          .fontSize(30)
          .borderRadius(10)
          .width('90%')
          .height(100)
          .textAlign(TextAlign.Center)
          .backgroundColor(Color.Green)
          .margin(3)

      }
      .margin(10)
      //是否开启轮播
      .loop(true)
      //是否自动轮播
      .autoPlay(true)
      //自动轮播时间间隔
      .interval(2000)
      //是否显示指示器
      .indicator(true)
      //指示器样式
      .indicatorStyle({
        size: 20,
        color: Color.Red,
        selectedColor: Color.Green,
        top: 0
      })
      //轮播方向
      .vertical(false)
      //每页是否显示多个子组件
      .displayCount(1)
      .displayMode(SwiperDisplayMode.AutoLinear)

      Row() {
        Button('上一个')
          .onClick(() => {
            this.swiperController.showPrevious()
          })
        Button('下一个')
          .onClick(() => {
            this.swiperController.showNext()
          })
      }.width('100%').justifyContent(FlexAlign.SpaceEvenly)
    }.height('100%')
    .width('100%')
  }
}