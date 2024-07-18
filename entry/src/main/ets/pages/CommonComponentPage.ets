import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import thermal from '@ohos.thermal'
import { CommonButton, CommonTitle } from './component/MyComponent'

@Entry
@Component
struct CommonComponentPage {
  private scroller: Scroller = new Scroller()
  @State toggleSwitch: string = '开'
  @State toggleCheckbox: string = '开'
  @State toggleButton: string = '开'
  @State counterIndex: number = 0
  @State marqueeStart: boolean = false
  @State marqueeFromStart: boolean = false
  private patternLockController: PatternLockController = new PatternLockController()
  private richTextContent: string =
    '<h1 style="color:blue;text-align:center;">这是h1标题</h1>' +
      '<h2 style="color:red;text-align:center;">这是h2标题</h2>' +
      '<h3><i>这是h3斜体标题</i></h3>' +
      '<h4><i>这是h4斜体标题</i></h4>' +
      '<h5><i>这是h5斜体标题</i></h5>' +
      '<h6><i>这是h6斜体标题</i></h6>' +
      '<p>这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊' +
      '这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊</p>'
  @State sliderStyle: SliderStyle = SliderStyle.OutSet
  // @State sliderDirection: Axis = Axis.Horizontal
  @State isSliderReverse: boolean = false
  @State isShowSliderSteps: boolean = false
  @State isShowSliderTips: boolean = false
  private textClockController: TextClockController = new TextClockController()
  @State isTextTimerCountDown: boolean = false
  private textTimerController: TextTimerController = new TextTimerController()

  @Styles
  normalBg(){
    .backgroundColor(Color.Red)
  }

  @Styles
  pressBg(){
    .backgroundColor(Color.Orange)
  }

  @Styles
  clickBg(){
    .backgroundColor(Color.Pink)
  }

  @Styles
  disableBg(){
    .backgroundColor(Color.Gray)
  }

  @Styles
  focusBg(){
    .backgroundColor(Color.Yellow)
  }

  build() {


    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '文本-Text' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/TextPage'
            })
          })
        CommonButton({ text: '按钮-Button' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/ButtonPage'
            })
          })
        CommonButton({ text: '输入框-TextInput' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/TextInputPage'
            })
          })
        CommonButton({ text: 'Toggle、Radio' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/TogglePage'
            })
          })


        CommonTitle({ title: 'Counter' })
        Counter() {
          Text(this.counterIndex + '').fontColor(Color.Red).fontSize(20)
        }.onInc(() => {
          this.counterIndex++
        })
        .onDec(() => {
          this.counterIndex--
        })

        CommonTitle({ title: 'Badge' })
        Badge({
          count: 10,
          maxCount: 99,
          position: BadgePosition.RightTop,
          style: {
            color: Color.White,
            fontSize: 10,
            badgeSize: 16,
            badgeColor: Color.Red
          }
        }) {
          Text('右上角的数字').fontSize(20).fontColor(Color.Black)
        }

        Badge({
          value: 'New',
          position: BadgePosition.Right,
          style: {
            color: Color.White,
            fontSize: 10,
            badgeSize: 16,
            badgeColor: Color.Red
          }
        }) {
          Text('右边的文本').fontSize(20).fontColor(Color.Black).margin({ right: 20 })
        }


        CommonTitle({ title: '进度条-Progress' })
        Progress({ value: 20, total: 100, type: ProgressType.Linear }).width(200).height(20)
          .margin({ bottom: 10 })
        Progress({ value: 40, total: 100, type: ProgressType.Ring })
          .width(80)
          .height(80)
          .color(Color.Red)
          .style({ strokeWidth: 5 })
          .margin({ bottom: 10 })
        Progress({ value: 40, total: 100, type: ProgressType.ScaleRing })
          .width(80)
          .height(80)
          .color(Color.Pink)
          .style({ scaleCount: 30, scaleWidth: 5, strokeWidth: 15 })
          .margin({ bottom: 10 })
        Progress({ value: 30, total: 100, type: ProgressType.Eclipse })
          .width(80).height(80).color(Color.Green).margin({ bottom: 10 })
        Row() {
          Progress({ value: 30, total: 100, type: ProgressType.Capsule })
            .color(Color.Orange).width(100).height(40).margin({ right: 10 })
          Progress({ value: 30, total: 100, type: ProgressType.Capsule })
            .margin({ right: 10 }).color(Color.Yellow).width(40).height(100)
          Progress({ value: 30, total: 100, type: ProgressType.Capsule })
            .color(Color.Red)
            .backgroundColor(Color.Green)
            .width(100)
            .height(40)
        }.margin({ bottom: 10 })

        CommonTitle({ title: 'LoadingProgress' })
        LoadingProgress()
          .color(Color.Red)
          .width(60)
          .height(60)

        CommonTitle({ title: 'Rating' })
        Rating({ rating: 3, indicator: false })
          .stars(10)
          .stepSize(0.5)// .starStyle({
            //   backgroundUri: $r('app.media.ic_star_bg'),
            //   foregroundUri: $r('app.media.ic_star_forward'),
            //   secondaryUri: $r('app.media.ic_star_second')
            // })
          .width('80%')
          .height(40)
          .onChange((value: number) => {
            console.debug('===rating：' + value)
          })

        //Slider
        CommonTitle({ title: 'Slider' })
        Slider({
          value: 10,
          min: 0,
          max: 100,
          step: 5,
          style: this.sliderStyle,
          reverse: this.isSliderReverse,
          direction: Axis.Horizontal
        })
          .blockColor(Color.Red)//滑块颜色
          .trackColor(Color.Green)//轨道颜色
          .selectedColor(Color.Pink)//已滑过部分的颜色
          .showSteps(this.isShowSliderSteps)//是否显示步进刻度
          .showTips(this.isShowSliderTips)//是否显示进度tips
            // .trackThickness(30)//轨道的粗细
          .onChange((value: number, mode: SliderChangeMode) => {
            console.debug('===Slider：' + value + '--' + mode)
          })
          .width(300)
        Slider({
          value: 10,
          min: 0,
          max: 100,
          step: 5,
          style: this.sliderStyle,
          reverse: this.isSliderReverse,
          direction: Axis.Vertical
        })
          .blockColor(Color.Red)//滑块颜色
          .trackColor(Color.Green)//轨道颜色
          .selectedColor(Color.Pink)//已滑过部分的颜色
          .showSteps(this.isShowSliderSteps)//是否显示步进刻度
          .showTips(this.isShowSliderTips)//是否显示进度tips
            // .trackThickness(30)//轨道的粗细
          .onChange((value: number, mode: SliderChangeMode) => {
            console.debug('===Slider：${value}--${mode}')
          })
          .height(300)
        Row() {
          Button('sliderStyle').onClick(() => {
            this.sliderStyle = this.sliderStyle == SliderStyle.OutSet ? SliderStyle.InSet : SliderStyle.OutSet
          })
          Button('isReverse').onClick(() => {
            this.isSliderReverse = !this.isSliderReverse
          })
        }.margin({ top: 10 })
        .justifyContent(FlexAlign.SpaceAround)

        Row() {
          Button('isShowSteps').onClick(() => {
            this.isShowSliderSteps = !this.isShowSliderSteps
          })
          Button('isShowTips').onClick(() => {
            this.isShowSliderTips = !this.isShowSliderTips
          })
        }.margin({ top: 10 })
        .justifyContent(FlexAlign.SpaceAround)


        CommonTitle({ title: 'TextClock' })
        TextClock({ timeZoneOffset: -8, controller: this.textClockController })
          .format('yyyy/MM/dd hh:mm:ss')
          .fontColor(Color.Pink)
          .fontSize(30)
          .fontWeight(FontWeight.Bolder)
          .onDateChange((value: number) => {

          })
        Row() {
          Button('Start-time').onClick(() => {
            this.textClockController.start()
          })
          Button('Stop-time').onClick(() => {
            this.textClockController.stop()
          })
        }.margin({ top: 10 })
        .width('100%').justifyContent(FlexAlign.SpaceEvenly)

        CommonTitle({ title: 'TextTimer' })
        TextTimer({ isCountDown: this.isTextTimerCountDown, count: 60000, controller: this.textTimerController })
          .fontColor(Color.Orange)
          .fontSize(30)
          .fontWeight(FontWeight.Bolder)
          .onTimer((utc: number, elapsedTime: number) => {
            console.debug('===TextTimer：' + utc + '--elapsedTime:' + elapsedTime)
          })
        Row() {
          Button('isCountDown').onClick(() => {
            this.isTextTimerCountDown = !this.isTextTimerCountDown
          })
          Button('start').onClick(() => {
            this.textTimerController.start()
          })
          Button('pause').onClick(() => {
            this.textTimerController.pause()
          })
          Button('reset').onClick(() => {
            this.textTimerController.reset()
          })
        }.justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: 10 })


        CommonTitle({ title: '跑马灯-Marquee' })
        Marquee({
          start: this.marqueeStart,
          step: 20,
          loop: -1,
          fromStart: this.marqueeFromStart,
          src: '一人我饮酒醉，醉把佳人成双对，两眼我独相随，只求他日能双归，娇女我轻抚琴，燕戏他紫竹林。十年戎马心孤单，隐退江湖归深山。'
        })
          .fontColor(Color.White)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .height(60)
          .backgroundColor(Color.Black)
          .margin({ bottom: 10 })
        Button('start-marquee')
          .onClick(() => {
            this.marqueeStart = true
            this.marqueeFromStart = !this.marqueeFromStart
          })
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

        CommonTitle({ title: 'PatternLock密码锁' })

        PatternLock(this.patternLockController)
          .sideLength('300vp')
          .circleRadius(30)//密码圆点的半径
          .regularColor(Color.Gray)//圆点未选中状态的颜色
          .selectedColor(Color.Green)//选中状态的颜色
          .activeColor(Color.Orange)//手指划过的激活状态颜色
          .pathColor(Color.Pink)//路径的颜色
          .pathStrokeWidth(20)
          .onPatternComplete((input: number[]) => {
            console.debug('===操作的密码索引：' + input.toString())
          })
        Button('重置')
          .onClick(() => {
            this.patternLockController.reset()
          }).margin({ top: 10 })

      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .scrollable(ScrollDirection.Vertical)
    .height('100%')
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)

  }
}

