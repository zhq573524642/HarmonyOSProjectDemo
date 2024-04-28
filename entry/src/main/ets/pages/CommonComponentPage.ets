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
        CommonTitle({ title: '按钮' })
        Flex({ wrap: FlexWrap.Wrap }) {
          //stateEffect是否可点击
          Button('普通按钮使用StateStyles+@Styles', { type: ButtonType.Normal, stateEffect: true })
            .fontColor(Color.Black)
            .backgroundColor(Color.Orange)
            .width(90)
            .height(40)
            .margin(10)
            .onClick(() => {
              promptAction.showToast({ message: '普通按钮' })
            })
            .stateStyles({
              normal: this.normalBg,
              pressed: this.pressBg,
              // focused: this.focusBg,
              // clicked: this.clickBg,
              // disabled: this.disableBg
            })
          Button('圆角按钮')
            .backgroundColor(Color.Yellow)
            .fontColor(Color.Black)
            .borderRadius(8)
            .width(90)
            .height(40)
            .margin(10)
            .onClick(() => {
              promptAction.showToast({ message: '圆角按钮' })
            })
          Button('圆形按钮', { type: ButtonType.Circle, stateEffect: true })
            .backgroundColor(Color.Green)
            .fontColor(Color.Black)
            .width(90)
            .height(40)
            .margin(10)
            .onClick(() => {
              promptAction.showToast({ message: '圆形按钮' })
            })
          Button('胶囊按钮', { type: ButtonType.Capsule, stateEffect: true })
            .backgroundColor(Color.Red)
            .fontColor(Color.Black)
            .width(90)
            .height(40)
            .margin(10)
            .onClick(() => {
              promptAction.showToast({ message: '胶囊按钮' })
            })
          Button('悬浮按钮', { type: ButtonType.Capsule, stateEffect: true })
            .backgroundColor(Color.Red)
            .fontColor(Color.Black)
            .width(90)
            .height(40)
            .shadow({ radius: 10 })
            .margin(10)
            .onClick(() => {
              promptAction.showToast({ message: '悬浮按钮' })
            })
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Image($r('app.media.ic_delete')).width(30).height(30)
          }
          .width(50)
          .height(50)
          .backgroundColor(Color.Red)
          .margin(10)
          .onClick(() => {
            promptAction.showToast({ message: '带图片按钮' })
          })
        }.width('100%')
        .padding(10)

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
        Badge({ count: 10, maxCount: 99, position: BadgePosition.RightTop, style: {
          color: Color.White, fontSize: 10, badgeSize: 16, badgeColor: Color.Red
        } }) {
          Text('右上角的数字').fontSize(20).fontColor(Color.Black)
        }

        Badge({
          value: 'New',
          position: BadgePosition.Right,
          style: { color: Color.White, fontSize: 10, badgeSize: 16, badgeColor: Color.Red }
        }) {
          Text('右边的文本').fontSize(20).fontColor(Color.Black).margin({ right: 20 })
        }

        CommonTitle({ title: '单选框-Radio' })
        Row() {
          Text('男')
            .fontSize(13)
          Radio({ value: 'man', group: 'group1' })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：男' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
          Text('女')
            .fontSize(13)
            .margin({ left: 20 })
          Radio({ value: 'woman', group: 'group1' })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：女' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
        }.alignItems(VerticalAlign.Center)

        CommonTitle({ title: '多选框-CheckboxGroup和Checkbox' })

        Column() {
          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            CheckboxGroup({ group: 'checkbox_group' })
              .selectedColor(Color.Pink)
              .onChange((event: CheckboxGroupResult) => {
                console.debug('===CheckboxGroup：' + event.name.toString())
              })
            Text('CheckboxGroup').fontColor(Color.Black).fontSize(13)
          }

          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: 'Item-1', group: 'checkbox_group' })
              .selectedColor(Color.Red)
              .onChange((isChecked: boolean) => {
                console.debug('===item1：' + isChecked)
              })
            Text('Item1').fontSize(13).fontColor(Color.Black)
          }.margin({ left: 36 })

          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: 'Item-2', group: 'checkbox_group' })
              .selectedColor(Color.Yellow)
              .onChange((isChecked: boolean) => {
                console.debug('===item2：' + isChecked)
              })
            Text('Item2').fontSize(13).fontColor(Color.Black)
          }.margin({ left: 36 })

          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: 'Item-3', group: 'checkbox_group' })
              .selectedColor(Color.Blue)
              .onChange((isChecked: boolean) => {
                console.debug('===item3：' + isChecked)
              })
            Text('Item3').fontSize(13).fontColor(Color.Black)
          }.margin({ left: 36 })
        }.width('100%')
        .alignItems(HorizontalAlign.Center)

        CommonTitle({ title: '切换按钮-ToggleType.Switch' })
        Toggle({ type: ToggleType.Switch, isOn: true })
          .onChange((isOn: Boolean) => {
            // this.toggleSwitch = isOn ? '开' : '关'
          })
          .switchPointColor(Color.Red)
          .selectedColor(Color.Green)
        CommonTitle({ title: '切换按钮-ToggleType.Checkbox' })
        Toggle({ type: ToggleType.Checkbox, isOn: true })
          .onChange((isOn: Boolean) => {
            // this.toggleCheckbox = isOn ? '开' : '关'
          })
          .selectedColor(Color.Pink)
        CommonTitle({ title: '切换按钮-ToggleType.Button' })
        Toggle({ type: ToggleType.Button, isOn: true }) {
          Text(this.toggleButton)
            .fontSize(15)
            .fontColor(Color.Black)
        }
        .selectedColor(Color.Brown)
        .width(40)
        .height(30)
        .onChange((isOn: Boolean) => {
          this.toggleButton = isOn ? '开' : '关'
        })

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

        //文本
        CommonTitle({ title: '文本-Text' })
        Text() {
          Span('文本子组件Span')
            .fontColor(Color.Blue)
            .fontSize(20)
            .margin(10)
            .fontStyle(FontStyle.Italic)
            .fontWeight(FontWeight.Bold)
            .decoration({ type: TextDecorationType.LineThrough, color: Color.Red })
        }

        Text('文本Text')
          .fontColor(Color.Orange)
          .fontSize(20)
          .fontWeight(FontWeight.Regular)
          .fontStyle(FontStyle.Normal)
          .minFontSize(15)
          .maxFontSize(30)
          .margin(10)
          .decoration({ type: TextDecorationType.Underline, color: Color.Pink })
        Text('These are all uppercase')
          .textCase(TextCase.UpperCase)
          .fontColor(Color.Black)
          .fontSize(20)
          .fontWeight(FontWeight.Regular)
          .fontStyle(FontStyle.Normal)
          .minFontSize(15)
          .maxFontSize(30)
          .margin(10)
        Text('可以复制：这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本' +
          '这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本' +
          '这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本')
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .lineHeight(30)
          .letterSpacing(2)
          .fontColor(Color.Black)
          .fontSize(20)
          .fontWeight(FontWeight.Regular)
          .fontStyle(FontStyle.Normal)
          .minFontSize(15)
          .maxFontSize(30)
          .margin(10)
          .copyOption(CopyOptions.InApp)
        // CommonTitle({ title: '富文本-RichText' })
        // RichText(this.richTextContent)
        //   .onStart(() => {
        //     console.debug('===richText-onStart')
        //   })
        //   .onComplete(() => {
        //     console.debug('===richText=-onComplete')
        //   })
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

        CommonTitle({ title: '搜索组件-Search' })
        Search({ placeholder: '请输入搜索的内容' })
          .searchButton('搜索')
          .placeholderColor(Color.Gray)
          .placeholderFont({ style: FontStyle.Normal, size: 14, weight: 500 })
          .textAlign(TextAlign.Center)
          .textFont({ size: 14, style: FontStyle.Italic, weight: 500 })
          .backgroundColor('#f5f5f5')
          .onSubmit((content: string) => {
            promptAction.showToast({ message: content })
          })
          .copyOption(CopyOptions.InApp)
          .onChange((content: string) => {

          })
          .onCopy((content: string) => {

          })
          .onCut((content: string) => {

          })
          .onPaste((content: string) => {

          })

        //输入框
        CommonTitle({ title: '输入框' })
        TextInput({ placeholder: '请输入账号' })
          .type(InputType.Number)
          .enterKeyType(EnterKeyType.Next)
          .backgroundColor(Color.Pink)
          .width(200)
          .height(50)
          .margin({ left: 15, right: 15 })
          .onChange((value: string) => {

          })
          .onFocus(() => {

          })
        TextInput({ placeholder: '请输入密码' })
          .type(InputType.Password)
          .enterKeyType(EnterKeyType.Go)
          .backgroundColor(Color.Pink)
          .width(200)
          .height(50)
          .margin({ top: 15, left: 15, right: 15 })
          .onSubmit((enterKey: EnterKeyType) => {
            promptAction.showToast({ message: enterKey + '' })
          })
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

