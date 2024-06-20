import { Point, PointVector } from './Point'
import { CommonButton, CommonTitle } from '../component/MyComponent'
import { router } from '@kit.ArkUI'

@AnimatableExtend(Text)
function animatableText(fontSize: number) {
  .fontSize(fontSize)
}

@AnimatableExtend(Polyline)
function animatablePoints(points: PointVector) {
  .points(points.get())
}

@Entry
@Component
struct AnimationPage {
  @State viewWidth: number = 90
  @State viewHeight: number = 40
  @State anim1Flag: boolean = false
  @State btnColor: Color = Color.Red
  @State fontSizeNumber: number = 15
  @State points: PointVector = new PointVector([
    new Point(50, Math.random() * 200),
    new Point(100, Math.random() * 200),
    new Point(150, Math.random() * 200),
    new Point(200, Math.random() * 200),
    new Point(250, Math.random() * 200),
  ])
  private scroller: Scroller = new Scroller()

  //Curve.Linear 表示动画从头到尾的速度都是相同的。
  //Curve.Ease 表示动画以低速开始，然后加快，在结束前变慢，CubicBezier(0.25, 0.1, 0.25, 1.0)。
  //Curve.EaseIn 表示动画以低速开始，CubicBezier(0.42, 0.0, 1.0, 1.0)。
  //Curve.EaseOut 表示动画以低速结束，CubicBezier(0.0, 0.0, 0.58, 1.0)。
  //Curve.EaseInOut 表示动画以低速开始和结束，CubicBezier(0.42, 0.0, 0.58, 1.0)。
  //Curve.FastOutSlowIn 标准曲线，cubic-bezier(0.4, 0.0, 0.2, 1.0)。
  //Curve.LinearOutSlowIn 减速曲线，cubic-bezier(0.0, 0.0, 0.2, 1.0)。
  //Curve.FastOutLinearIn 加速曲线，cubic-bezier(0.4, 0.0, 1.0, 1.0)。
  //Curve.ExtremeDeceleration 急缓曲线，cubic-bezier(0.0, 0.0, 0.0, 1.0)。
  //Curve.Sharp 锐利曲线，cubic-bezier(0.33, 0.0, 0.67, 1.0)。
  //Curve.Rhythm 节奏曲线，cubic-bezier(0.7, 0.0, 0.2, 1.0)。
  //Curve.Smooth 平滑曲线，cubic-bezier(0.4, 0.0, 0.4, 1.0)。
  //Curve.Friction 阻尼曲线，CubicBezier(0.2, 0.0, 0.2, 1.0)。

  build() {

    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '一、@AnimatableExtend装饰器：定义可组件动画属性' })
        Text('这是一串文本')
          .animatableText(this.fontSizeNumber)
          .animation({ duration: 500, curve: Curve.Ease })
        Button('点击改变字体大小')
          .margin(10)
          .onClick(() => {
            this.fontSizeNumber = this.fontSizeNumber == 15 ? 25 : 15
          })
        CommonTitle({ title: '二、@AnimatableExtend装饰器：实现折线动画' })
        Polyline()
          .animatablePoints(this.points)
          .animation({ duration: 1000, curve: "ease" })
          .size({ height: 220, width: 300 })
          .fill(Color.Green)
          .stroke(Color.Red)
          .backgroundColor('#eeaacc')
        Button('点击开始折线动画')
          .margin(10)
          .onClick(() => {
            this.points = new PointVector([
              new Point(50, Math.random() * 200),
              new Point(100, Math.random() * 200),
              new Point(150, Math.random() * 200),
              new Point(200, Math.random() * 200),
              new Point(250, Math.random() * 200),
            ])
          })

        CommonButton({ text: '属性动画' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/animate/PropertyAnimatePage'
            })
          })

        CommonButton({ text: '转场动画' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/animate/TransitionEffectPage'
            })
          })

      }
      .width('100%')
    }.width('100%')
  }
}

