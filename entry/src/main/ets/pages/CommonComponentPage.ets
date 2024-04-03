import promptAction from '@ohos.promptAction'
import { CommonButton, CommonTitle } from './component/MyComponent'

@Entry
@Component
struct CommonComponentPage {
  private scroller: Scroller = new Scroller()
  @State toggleSwitch: string = '开'
  @State toggleCheckbox: string = '开'
  @State toggleButton: string = '开'
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({ content: '你的账号可能在别的设备登录',
      onCancel: this.onDialogCancel,
      onConfirm: this.onDialogConfirm })
    ,alignment:DialogAlignment.Bottom
  })

  onDialogCancel() {
    promptAction.showToast({ message: 'Dialog取消' })
  }

  onDialogConfirm() {
    promptAction.showToast({ message: 'Dialog确定' })
  }

  build() {

    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '按钮' })
        Flex({ wrap: FlexWrap.Wrap }) {
          //stateEffect是否可点击
          Button('普通按钮', { type: ButtonType.Normal, stateEffect: true })
            .fontColor(Color.Black)
            .backgroundColor(Color.Orange)
            .width(90)
            .height(40)
            .margin(10)
            .onClick(() => {
              promptAction.showToast({ message: '普通按钮' })
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

        CommonTitle({ title: '单选框' })
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

        CommonTitle({ title: '进度条' })
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
        //文本
        CommonTitle({ title: '文本' })
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
        //自定义弹窗
        CommonButton({ text: '自定义弹窗' })
          .onClick(() => {
            this.dialogController.open()
          })


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

@CustomDialog
struct CustomDialogExample {
  private content: string
  controller: CustomDialogController
  onCancel: () => void
  onConfirm: () => void

  build() {
    Column() {
      Text('温馨提示')
        .fontColor(Color.Black)
        .fontSize(20)
        .margin({ top: 10 })
        .fontWeight(FontWeight.Bold)
      Text(this.content)
        .fontColor(Color.Gray)
        .fontSize(15)
        .margin({ top: 10, bottom: 10 })
        .fontWeight(FontWeight.Normal)
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消', { type: ButtonType.Normal })
          .width(60)
          .height(40)
          .borderRadius(8)
          .backgroundColor(Color.Gray)
          .fontSize(13)
          .fontColor(Color.Black)
          .onClick(() => {
            this.controller.close()
            this.onCancel()
          })
        Button('确定', { type: ButtonType.Normal })
          .width(60)
          .height(40)
          .borderRadius(8)
          .backgroundColor(Color.Green)
          .fontSize(13)
          .fontColor(Color.White)
          .onClick(() => {
            this.controller.close()
            this.onConfirm()
          })
      }.width('100%')
      .margin({ top: 15, bottom: 15 })
    }
    .padding(20)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .margin(10)
    .borderRadius(10)
    .backgroundColor(Color.White)
  }
}