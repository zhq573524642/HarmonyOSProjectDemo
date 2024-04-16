@Entry
@Component
struct ShapePage {
  private scroller: Scroller = new Scroller()

  build() {

    Scroll(this.scroller) {
      Column({ space: 15 }) {
        Text('viewPort效果').fontSize(20)
        Text('原始的Circle')
        Circle()
          .height(75).width(75).fill(Color.Red)
        Text('被放大2倍的CirCle\n'
        + 'Shape宽高150，viewPort宽高75，画半径75的圆')
        Shape() {
          Rect().width('100%').height('100%').fill(Color.Green)
          Circle()
            .fill(Color.Red)
            .width(75)
            .height(75)
        }
        .viewPort({ x: 0, y: 0, width: 75, height: 75 })
        .width(150)
        .height(150)
        .backgroundColor(Color.Orange)

        Text('被缩小2倍的Circle\n'
        + 'Shape宽高150，viewPort宽高300，画半径75的圆')
        Shape() {
          Rect().width('100%').height('100%').fill(Color.Green)
          Circle()
            .fill(Color.Red)
            .width(75)
            .height(75)
        }
        .viewPort({ x: 0, y: 0, width: 300, height: 300 })
        .width(150)
        .height(150)
        .backgroundColor(Color.Orange)

        Text('半径为75的Circle\n' +
        'Shape宽高300，viewPort宽高300，画半径75的圆')
        Shape() {
          Rect().width('100%').height('100%').fill(Color.Green)
          Circle()
            .fill(Color.Red)
            .width(75)
            .height(75)
        }
        .viewPort({ x: 0, y: 0, width: 300, height: 300 })
        .width(300)
        .height(300)
        .backgroundColor(Color.Orange)

        Text('偏移150的半径为75的Circle\n'
        + 'Shape宽高300，viewPort宽高300,偏移-150，画半径75的圆')
        Shape() {
          Rect().width('100%').height('100%').fill(Color.Green)
          Circle()
            .fill(Color.Red)
            .width(75)
            .height(75)
        }
        .viewPort({ x: -150, y: -150, width: 300, height: 300 })
        .width(300)
        .height(300)
        .backgroundColor(Color.Orange)

        Text('自定义样式Path（300vp*300vp）\n其中坐标点的单位为px，实际宽度为1440像素的屏幕上，1vp=3px')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('Path:三角 M450 0 L900 900 L0 900 Z')
        Path()
          .width('300vp')
          .height('300vp')
          .fill(Color.Red)//填充颜色
          .fillOpacity(0.2)//填充透明度
          .commands('M450 0 L900 900 L0 900 Z')
          .stroke(Color.Blue) //边框
          // .strokeOpacity(0.3)//边框透明度
          .strokeWidth(10)//边框宽度
          .strokeDashOffset(10)

          .strokeLineJoin(LineJoinStyle.Bevel)


      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
    }
    .width('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)

  }
}