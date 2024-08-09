import { CommonTitle } from './MyComponent'

@Entry
@Component
struct RatingSliderPage {
  private scroller: Scroller = new Scroller()
  @State sliderStyle: SliderStyle = SliderStyle.OutSet
  // @State sliderDirection: Axis = Axis.Horizontal
  @State isSliderReverse: boolean = false
  @State isShowSliderSteps: boolean = false
  @State isShowSliderTips: boolean = false

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        CommonTitle({ title: 'Rating' })
        Rating({ rating: 3, indicator: false })
          .stars(10)
          .stepSize(0.5)
          .width('80%')
          .height(40)
          .onChange((value: number) => {
            console.debug('===rating：' + value)
          })
        Rating({ rating: 3, indicator: true })
          .stars(10)
          .stepSize(0.5)
          .width('80%')
          .height(40)
          .onChange((value: number) => {
            console.debug('===rating：' + value)
          })
        Rating({ rating: 3, indicator: false })
          .stars(8)
          .stepSize(0.5)
          .starStyle({
            backgroundUri: 'images/ic_star_bg.png',
            foregroundUri: 'images/ic_star_forward.png',
            secondaryUri: 'images/ic_star_second.png'
          })
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
          .showTips(this.isShowSliderTips)//是否显示进度tips
          .blockStyle({ type: SliderBlockType.IMAGE, image: $r('app.media.ic_star_forward') })
          .showSteps(this.isShowSliderSteps)//是否显示步进刻度
          .stepColor(Color.Pink)//步进颜色
          .stepSize(5)//步进刻度点的大小
          .trackThickness(10)//轨道的粗细
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
          .blockColor(Color.Orange)//滑块描边颜色
          .blockBorderWidth(2)
          .trackThickness(10)//轨道的粗细
          .onChange((value: number, mode: SliderChangeMode) => {
            console.debug('===Slider：${value}--${mode}')
          })
          .height(300)
        Row({ space: 10 }) {
          Button('sliderStyle').onClick(() => {
            this.sliderStyle = this.sliderStyle == SliderStyle.OutSet ? SliderStyle.InSet : SliderStyle.OutSet
          })
          Button('isReverse').onClick(() => {
            this.isSliderReverse = !this.isSliderReverse
          })
        }
        .justifyContent(FlexAlign.SpaceAround)

        Row({ space: 10 }) {
          Button('isShowSteps').onClick(() => {
            this.isShowSliderSteps = !this.isShowSliderSteps
          })
          Button('isShowTips').onClick(() => {
            this.isShowSliderTips = !this.isShowSliderTips
          })
        }
        .justifyContent(FlexAlign.SpaceAround)

      }.width('100%')
    }
  }
}