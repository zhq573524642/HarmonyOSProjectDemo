import { MyProgressModifier } from './CustomProgressView'
import { CommonButton, CommonTitle } from './MyComponent'

@Entry
@Component
struct ProgressPage {
  private scroller: Scroller = new Scroller()
  @State progressIndex: number = 0
  private gradientColor: LinearGradient = new LinearGradient([{ color: Color.Yellow, offset: 0.5 },
    { color: Color.Orange, offset: 1.0 }])
  @State currentValue: number = 0
  modifier = new MyProgressModifier(Color.Red)
  @State myModifier: (MyProgressModifier | undefined) = this.modifier

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        CommonButton()
          .onClick(() => {
            if (this.progressIndex == 100) {
              this.progressIndex = 0
            }
            this.progressIndex += 10
          })
        //1.线性水平进度条
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.Linear })
          .width(200).height(20)
          .style({ strokeWidth: 15, enableScanEffect: true })
          .color(Color.Green)

        //2.环形进度条
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.Ring })
          .width(80)
          .height(80)
          .color(Color.Red)
          .style({ strokeWidth: 15 })
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.Ring })
          .width(80)
          .height(80)
          .color(this.gradientColor)
          .style({ strokeWidth: 15 })
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.Ring })
          .width(80)
          .height(80)
          .color(Color.Yellow)
          .style({ strokeWidth: 15, shadow: true })
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.Ring })
          .width(80)
          .height(80)
          .color(Color.Pink)
          .style({ strokeWidth: 15, status: ProgressStatus.LOADING })
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.Ring })
          .width(80)
          .height(80)
          .color(Color.Orange)
          .style({ strokeWidth: 15, enableScanEffect: true })
        //3.环形刻度进度条
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.ScaleRing })
          .width(80)
          .height(80)
          .color(Color.Pink)
          .style({ scaleCount: 30, scaleWidth: 5, strokeWidth: 15 })
        //4.圆形进度条
        Progress({ value: this.progressIndex, total: 100, type: ProgressType.Eclipse })
          .width(80).height(80).color(Color.Green)
        //5.胶囊进度条
        Row({ space: 10 }) {
          Progress({ value: this.progressIndex, total: 100, type: ProgressType.Capsule })
            .color(Color.Orange).width(100).height(40)
            .style({
              showDefaultPercentage: true
            })
          Progress({ value: this.progressIndex, total: 100, type: ProgressType.Capsule })
            .color(Color.Yellow).width(40).height(100)
          Progress({ value: this.progressIndex, total: 100, type: ProgressType.Capsule })
            .color(Color.Red)
            .backgroundColor(Color.Pink)
            .style({ content: '加载中', showDefaultPercentage: true, enableScanEffect: true })
            .width(100)
            .height(40)
        }

        Progress({ value: this.currentValue, total: 3, type: ProgressType.Linear })
          .contentModifier(this.modifier)
        Row({ space: 10 }) {
          Button('Progress++').onClick(() => {
            if (this.currentValue < 3) {
              this.currentValue += 1
            }
          })
          Button('Progress--').onClick(() => {
            if (this.currentValue > 0) {
              this.currentValue -= 1
            }
          })
        }

        CommonTitle({ title: 'DataPanel' })
        Stack() {
          DataPanel({ values: [60], type: DataPanelType.Circle, max: 100 }).width(150).height(150)
          Text('60%').fontColor(Color.Black).fontSize(30)
        }.margin(10)

        Stack() {
          DataPanel({ values: [50, 12, 10, 8], type: DataPanelType.Circle, max: 100 }).width(150).height(150)
          Text('60%').fontColor(Color.Black).fontSize(30)
        }.margin(10)

        Stack() {
          DataPanel({ values: [10, 10, 10, 10, 10, 10], type: DataPanelType.Line, max: 100 }).width(150).height(10)
        }.margin(10)

        CommonTitle({ title: 'Gauge' })
        Gauge({ value: 40, min: 0, max: 100 })
          .width(60)
          .height(60)
          .startAngle(0)
          .endAngle(360)
          .strokeWidth(10)
          .value(60)
          .borderColor(Color.Red)
          .colorBlend(Color.Green)
          .colors([[Color.Red, 2], [Color.Yellow, 1], [Color.Blue, 1], [Color.Pink, 1], [Color.Brown, 1]])
      }.width('100%')
    }.width('100%')
  }
}