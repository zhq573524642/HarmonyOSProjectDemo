import { curves } from '@kit.ArkUI'

@Entry
@Component
struct PropertyAnimatePage {
  @State isAnimate: boolean = false
  @State animateBoderRaduis: number = 10
  @State animateXRotate: number = 0
  @State animateXTranslate: number = 0
  @State animateOpacity: number = 1
  @State animateWidth: number = 60
  @State animateHeight: number = 60


  @State isAnimate1: boolean = false
  @State animateBoderRaduis1: number = 10
  @State animateXRotate1: number = 0
  @State animateXTranslate1: number = 0
  @State animateOpacity1: number = 1
  @State animateWidth1: number = 60
  @State animateHeight1: number = 60

  build() {

    Column() {
      Column() {

      }
      .width(100)
      .height(100)
      .margin(20)
      .rotate({ angle: this.animateXRotate })
      .borderRadius(this.animateBoderRaduis)
      .backgroundColor(Color.Green)

      Column() {

      }
      .margin(20)
      .width(this.animateWidth)
      .height(this.animateHeight)
      .borderRadius(30)
      .opacity(this.animateOpacity)
      .backgroundColor(Color.Red)
      .translate({ x: this.animateXTranslate })

      Button('animateTo:开始动画')
        .onClick(() => {
          animateTo({ curve: curves.springMotion() }, () => {
            this.isAnimate = !this.isAnimate
            this.animateBoderRaduis = this.isAnimate ? 30 : 10
            this.animateXRotate = this.isAnimate ? 90 : 0
            this.animateXTranslate = this.isAnimate ? 100 : 0
            this.animateOpacity = this.isAnimate ? 0.5 : 1
            this.animateWidth = this.isAnimate ? 100 : 60
            this.animateHeight = this.isAnimate ? 100 : 60
          })

        })

      Column() {

      }
      .width(100)
      .height(100)
      .margin(20)
      .rotate({ angle: this.animateXRotate1 })
      .borderRadius(this.animateBoderRaduis1)
      .backgroundColor(Color.Orange)
      .animation({curve:curves.springMotion()})

      Column() {

      }
      .margin(20)
      .width(this.animateWidth1)
      .height(this.animateHeight1)
      .borderRadius(30)
      .opacity(this.animateOpacity1)
      .backgroundColor(Color.Pink)
      .translate({ x: this.animateXTranslate1 })
      .animation({curve:curves.springMotion()})

      Button('animation:开始动画')
        .onClick(() => {
            this.isAnimate1 = !this.isAnimate1
            this.animateBoderRaduis1 = this.isAnimate1 ? 30 : 10
            this.animateXRotate1 = this.isAnimate1 ? 90 : 0
            this.animateXTranslate1 = this.isAnimate1 ? 100 : 0
            this.animateOpacity1 = this.isAnimate1 ? 0.5 : 1
            this.animateWidth1 = this.isAnimate1 ? 100 : 60
            this.animateHeight1 = this.isAnimate1 ? 100 : 60


        })

    }
    .width('100%')

  }
}