import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import thermal from '@ohos.thermal'
import { CommonButton, CommonTitle } from './component/MyComponent'

@Entry
@Component
struct CommonComponentPage {
  private scroller: Scroller = new Scroller()

  private patternLockController: PatternLockController = new PatternLockController()


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
        CommonButton({ text: '进度条Progress' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/ProgressPage'
            })
          })
        CommonButton({ text: 'Rating/Slider' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/RatingSliderPage'
            })
          })
        CommonButton({text:'日期时间组件'})
          .onClick(()=>{
             router.pushUrl({
               url:'pages/component/DateTimePage'
             })
          })


        CommonTitle({ title: 'PatternLock密码锁' })

        PatternLock(this.patternLockController)
          .sideLength('300vp')
          .circleRadius(20)//密码圆点的半径
          .regularColor(Color.Gray)//圆点未选中状态的颜色
          .selectedColor(Color.Green)//选中状态的颜色
          .activeColor(Color.Orange)//手指划过的激活状态颜色
          .pathColor(Color.Pink)//路径的颜色
          .pathStrokeWidth(15)
          .onPatternComplete((input: number[]) => {
            console.debug('===操作的密码索引：' + input.toString())
          })
          .onDotConnect((callback:number)=>{
             console.debug('===选中的密码：'+callback)
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

