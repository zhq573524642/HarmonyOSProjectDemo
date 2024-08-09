import { CommonButton } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ArkUIPage {
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '通用属性' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkui/CommonPropertyPage'
            })
          })
        CommonButton({ text: '沉浸式效果' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/ImmersionPage'
            })
          })
        CommonButton({ text: '容器组件' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/ContainerComponentPage' })
          })
        CommonButton({ text: '常用组件' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/CommonComponentPage' })
          })
        CommonButton({ text: 'Navigation' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/navigation/NavigationTestPage'
            })
          })
        CommonButton({ text: '气泡和菜单' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/component/PopupMenuPage' })
          })
        CommonButton({ text: '图片显示Image' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/component/ImagePage' })
          })
        CommonButton({ text: '几何图形Shape' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/component/ShapePage' })
          })
        CommonButton({ text: '视频播放' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/component/VideoPlayPage' })
          })
        CommonButton({ text: '二维码' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/component/QCodePage' })
          })
        CommonButton({ text: '绘制组件' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/canvas/BaseCanvasPage' })
          })
      }
      .width('100%')
    }.width('100%')

  }
}