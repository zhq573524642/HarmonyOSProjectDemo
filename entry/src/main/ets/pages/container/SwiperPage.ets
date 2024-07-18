@Entry
@Component
struct SwiperPage {
  private swiperController: SwiperController = new SwiperController()
  private imageList: Array<Resource> = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]

  build() {
    Column() {
      Swiper(this.swiperController) {
        ForEach(this.imageList, (item: Resource) => {
          Image(item)
            .width('90%')
            .height(160)
            .objectFit(ImageFit.Cover)
            .borderRadius(10)
        })
      }
      .duration(500) //轮播动画的时长
      .margin(10)
      .itemSpace(20) //每个条目的间隔
      //是否开启轮播
      .loop(true)
      //是否自动轮播
      .autoPlay(true)
      //自动轮播时间间隔
      .interval(2000)
      //是否显示指示器
      .indicator(DotIndicator.dot()
        .itemWidth(10)
        .itemHeight(10)
        .selectedItemWidth(15)
        .selectedItemHeight(15)
        .color(Color.Green)
        .selectedColor(Color.Red)
        .mask(true))
      //数字指示器
      // .indicator(DotIndicator.digit()
      //   .fontColor(Color.Yellow)
      //   .selectedFontColor(Color.Pink)
      //   .right(20))
      //箭头
      .displayArrow({
        showBackground: true,
        isSidebarMiddle: true,
        backgroundSize: 50,
        backgroundColor: Color.Pink,
        arrowSize: 20,
        arrowColor: Color.Blue
      })
      //轮播方向
      .vertical(false)
      //每页是否显示多个子组件
      .displayCount(1)
      .displayMode(SwiperDisplayMode.STRETCH)

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