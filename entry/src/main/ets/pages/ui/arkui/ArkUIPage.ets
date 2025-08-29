import { CommonButton } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'
import { ContainerComponentPage } from '../../container/ContainerComponentPage'
import { RouterUtil } from '@ohos/common'
import { QCodePage } from '../../component/QCodePage'
import { PopupMenuPage } from '../../component/PopupMenuPage'

@Entry({ routeName: 'ArkUIPage' })
@Component
export struct ArkUIPage {
  private scroller: Scroller = new Scroller()

  static startPage() {
    RouterUtil.pushNamedRoute('ArkUIPage')
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '通用属性' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkui/CommonPropertyPage'
            })
          })
        CommonButton({ text: '组件生命周期' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkui/ComponentLifecyclePage'
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
            ContainerComponentPage.startPage()
          })
        CommonButton({ text: '常用组件' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/CommonComponentPage' })
          })
        CommonButton({ text: '组合高级组件' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/component/HighRankComponentPage'
            })
          })
        CommonButton({ text: 'Navigation' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/navigation/NavigationTestPage'
            })
          })
        CommonButton({ text: '弹出框' })
          .onClick(() => {
            PopupMenuPage.startPage()
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
            QCodePage.startPage()
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