import { CommonTitle } from '../component/MyComponent'

@Entry
@Component
struct BaseCanvasPage {
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '圆形绘制Circle' })

        Circle()
          .stroke(Color.Green)//描边颜色
          .strokeWidth(10)// .strokeLineCap(LineCapStyle.Round)//设置边框端点绘制样式。
          .strokeDashArray([3, 3])//设置边框间隙。默认值：[]
            // .strokeDashOffset(50)//边框绘制起点的偏移量。默认值：0
          .fill(Color.Red)//填充
          .antiAlias(true)//抗锯齿
          .width(100)
          .height(100)
        Circle()
          .margin({ top: 10 })
          .stroke(Color.Orange)//描边颜色
          .strokeWidth(10)// .strokeLineCap(LineCapStyle.Round)//设置边框端点绘制样式。
          .strokeDashArray([3, 3])//设置边框间隙。默认值：[]
            // .strokeDashOffset(50)//边框绘制起点的偏移量。默认值：0
          .fill(Color.Transparent)//填充
          .antiAlias(true)//抗锯齿
          .width(100)
          .height(100)

        CommonTitle({ title: '椭圆绘制Ellipse' })
        Ellipse({ width: 150, height: 80 })
          .stroke(Color.Red)
          .strokeWidth(3)
          .antiAlias(true)
        CommonTitle({ title: '线条绘制Line' })
        Line()
          .width(200)
          .height(200)
          .startPoint([0, 0])
          .endPoint([100, 100])
          .strokeWidth(3)
          .stroke(Color.Blue)
          .backgroundColor('#f5f5f5')
          .strokeLineCap(LineCapStyle.Round)
        Line()
          .width(100)
          .height(100)
          .startPoint([50, 50])
          .endPoint([100, 100])
          .stroke(Color.Red)
          .strokeWidth(3)
          .strokeDashArray([1, 2, 3])
          .backgroundColor('#f5f5f5')
          .margin({ top: 5 })
          .strokeLineCap(LineCapStyle.Round)
        CommonTitle({ title: '折线绘制Polyline' })
        Polyline()
          .width(100)
          .height(100)
          .fill(Color.Transparent)
          .backgroundColor('#f5f5f5')
          .points([[5, 5], [10, 10], [15, 15], [10, 30], [5, 40], [50, 50], [50, 60], [70, 70]])
          .stroke(Color.Blue)
          .strokeWidth(3)
        CommonTitle({ title: '多边形绘制Polygon' })
        //最后一点首位相连
        Polygon()
          .width(100)
          .height(100)
          .backgroundColor('#f5f5f5')
          .points([[50, 0], [100, 100], [0, 100]])
          .stroke(Color.Red)
          .fill(Color.Transparent)
          .strokeWidth(3)
        Polygon()
          .width(100)
          .height(100)
          .margin({ top: 10 })
          .stroke(Color.Green)
          .backgroundColor('#f5f5f5')
          .strokeWidth(3)
          .fill(Color.Orange)
          .points([[50, 0], [100, 50], [50, 100], [0, 50], [50, 0]])
        Polygon()
          .width(100)
          .height(100)
          .margin({ top: 10 })
          .stroke(Color.Yellow)
          .backgroundColor('#f5f5f5')
          .strokeWidth(3)
          .fill(Color.Red)
          .antiAlias(true)
          .points([[0, 35], [100, 35], [0, 100], [50, 0], [100, 100], [0, 35]])
        CommonTitle({ title: '路径绘制Path' })
        Path()
          .strokeWidth(3)
          .stroke(Color.Red)
          .fill(Color.Transparent)
          .commands(
            'M0 100 H150 L180 0 L180 180 L210 50 L220 120 L240 100 H100 L350 100'
          )
        Path()
          .commands('M0 150 C0 100 140 0 200 150 L100 300 Z')
          .fillOpacity(0)
          .stroke(Color.Black)
          .strokeWidth(3)

        CommonTitle({title:'矩形Rect'})
        Rect()
          .width(200)
          .height(100)
          .radius(20)
          .fill(Color.Pink)
          .stroke(Color.Orange)
          .antiAlias(true)
      }.width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)
  }
}