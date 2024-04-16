import { CommonButton } from './component/MyComponent'

@Entry
@Component
struct AnimationPage {
  @State viewWidth: number = 90
  @State viewHeight: number = 40
  @State anim1Flag: boolean = false
  @State btnColor: Color = Color.Red

  build() {

    Column() {
      Text('页面内动画：布局更新动画').margin(8).fontWeight(FontWeight.Bold)
      Text('显示动画 animateTo').margin(8)
      Column() {
        Button('按钮')
          .width(this.viewWidth)
          .height(this.viewHeight)
          .backgroundColor(Color.Red)

      }.width('100%')
      .height(100)

      Button('点击')
        .width('100vp')
        .onClick(() => {
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
          animateTo({ duration: 1000, curve: Curve.Friction }, () => {
            if (this.anim1Flag) {
              this.viewWidth = 45
              this.viewHeight = 20
            } else {
              this.viewWidth = 180
              this.viewHeight = 80
            }
            this.anim1Flag = !this.anim1Flag
          })
        })
      Text('属性动画 animation，在此之上的属性参与动画').margin(8)
      Column() {
        Button('按钮')
          .width(this.viewWidth)
          .height(this.viewHeight)
          .animation({ duration: 1000, curve: Curve.Sharp })
          .backgroundColor(this.btnColor)
      }.width('100%')
      .height(100)

      Button('点击')
        .width('100vp')
        .onClick(() => {
          animateTo({ duration: 1000, curve: Curve.EaseIn }, () => {
            if (this.anim1Flag) {
              this.viewWidth = 45
              this.viewHeight = 20
              this.btnColor = Color.Green
            } else {
              this.viewWidth = 180
              this.viewHeight = 80
              this.btnColor = Color.Pink
            }
            this.anim1Flag = !this.anim1Flag
          })
        })
      Text('页面内动画：组件内转场动画').margin(8).fontWeight(FontWeight.Bold)
      Column() {
        if (this.anim1Flag) {
          Button('按钮')
            .width(100)
            .backgroundColor(Color.Orange)
            .height(50)
            .transition({ type: TransitionType.Insert, translate: { x: 50, y: 50 }, opacity: 0 })
            .transition({ type: TransitionType.Delete, rotate: { x: 0, y: 0, z: 1, angle: -360 } })
        }

      }.width('100%')
      .height(100)

      Button('点击')
        .width('100vp')
        .onClick(() => {
          animateTo({ duration: 1000 }, () => {
            this.anim1Flag = !this.anim1Flag
          })
        })
    }
    .width('100%')
  }
}