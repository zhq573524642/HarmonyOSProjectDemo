import { promptAction } from '@kit.ArkUI'
import { CommonTitle } from './MyComponent'
import { ProgressButton } from '@ohos.arkui.advanced.ProgressButton'

@Entry
@Component
struct ButtonPage {
  private scroller: Scroller = new Scroller()
  @State progressBtnTex: string = '开始下载'
  @State progressIndex: number = 0
  @State progressEnable: boolean = true

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
        //ButtonType按钮类型
        //stateEffect按钮是否开启点击效果
        Button('普通按钮使用StateStyles+@Styles', { type: ButtonType.Normal, stateEffect: true })
          .fontColor(Color.Black)
          .backgroundColor(Color.Orange)
          .width('60%')
          .margin(10)
          .onClick(() => {
            promptAction.showToast({ message: '普通按钮' })
          })
          .stateStyles({
            normal: this.normalBg,
            pressed: this.pressBg,
            focused: this.focusBg,
            clicked: this.clickBg,
            disabled: this.disableBg
          })

        Button('圆角按钮')
          .backgroundColor(Color.Yellow)
          .fontColor(Color.Black)
          .borderRadius(8)
          .width('60%')
          .margin(10)
          .onClick(() => {
            promptAction.showToast({ message: '圆角按钮' })
          })

        Button('圆', { type: ButtonType.Circle, stateEffect: true })
          .backgroundColor(Color.Green)
          .fontColor(Color.Black)
          .width(50)
          .height(50)
          .margin(10)
          .onClick(() => {
            promptAction.showToast({ message: '圆形按钮' })
          })
        //不支持重新设置按钮圆角大小
        Button('胶囊按钮', { type: ButtonType.Capsule, stateEffect: true })
          .backgroundColor(Color.Red)
          .fontColor(Color.Black)
          .width('60%')
          .margin(10)
          .onClick(() => {
            promptAction.showToast({ message: '胶囊按钮' })
          })

        Button('悬浮按钮', { type: ButtonType.Capsule, stateEffect: true })
          .backgroundColor(Color.Red)
          .fontColor(Color.Black)
          .width('60%')
          .height(40)
          .shadow({ radius: 10 })
          .margin(10)
          .onClick(() => {
            promptAction.showToast({ message: '悬浮按钮' })
          })
        //只支持包含一个子组件（基础组件或者是容器组件）
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

        Button() {
          Row() {
            Image($r('app.media.im_rotate_loading')).width(25).height(25)
            Text('加载中...').fontSize(13).fontColor(Color.Black).margin({ left: 6 })
          }
          .padding({
            left: 20,
            top: 10,
            right: 20,
            bottom: 10
          })
        }
        .margin(10)
        .backgroundColor(Color.Pink)
        .borderRadius(10)


        Button() {
          Row() {
            LoadingProgress().width(25).height(25).color(Color.Black)
            Text('加载中...').fontSize(13).fontColor(Color.Black).margin({ left: 6 })
          }
          .padding({
            left: 20,
            top: 10,
            right: 20,
            bottom: 10
          })
        }
        .margin(10)
        .backgroundColor(Color.Pink)
        .borderRadius(10)

        ProgressButton({
          progress: this.progressIndex,
          content: this.progressBtnTex,
          enable: this.progressEnable,
          progressButtonWidth: 200,
          clickCallback: () => {
            if (this.progressEnable && this.progressIndex === 0) {
              this.progressBtnTex = '下载中'
              this.progressEnable = false
              let timer = setInterval(() => {
                this.progressIndex++
                if (this.progressIndex === 100) {
                  clearInterval(timer)
                  this.progressBtnTex = '开始下载'
                  this.progressIndex = 0
                  this.progressEnable = true
                }
              }, 1000)
            }
          }
        })
          .margin(10)

        Button('渐变按钮')
          .width('60%')
          .backgroundColor('#00000000')
          .linearGradient({
            angle: 90,
            colors: [[0xff0000, 0.0], [0x0000ff, 0.3], [0xffff00, 1.0]]
          })
          .onClick(() => {
            promptAction.showToast({ message: '渐变色按钮' })
          })
        //ButtonStyleMode按钮的样式和重要程度 强调按钮>普通按钮>文字按钮
        //ControlSize 描述按钮尺寸
        //ButtonRole 按钮角色
        CommonTitle({ title: 'ButtonStyleMode按钮样式和重要程度' })
        Button('强调文字', {
          buttonStyle: ButtonStyleMode.TEXTUAL,
          controlSize: ControlSize.NORMAL,
          role: ButtonRole.NORMAL
        })
          .backgroundColor(Color.Pink)
          .width('60%')
          .margin(10)
        Button('强调按钮', {
          buttonStyle: ButtonStyleMode.EMPHASIZED,
          controlSize: ControlSize.NORMAL,
          role: ButtonRole.NORMAL
        })
          .margin(10)
          .backgroundColor(Color.Pink)
          .width('60%')
        Button('普通', {
          buttonStyle: ButtonStyleMode.NORMAL,
          controlSize: ControlSize.NORMAL,
          role: ButtonRole.NORMAL
        })
          .margin(10)
          .backgroundColor(Color.Pink)
          .width('60%')
        Button('ERROR', {
          buttonStyle: ButtonStyleMode.NORMAL,
          controlSize: ControlSize.NORMAL,
          role: ButtonRole.ERROR
        })
          .margin(10)
          .backgroundColor(Color.Pink)


      }.width('100%')
    }
    .width('100%')
  }
}