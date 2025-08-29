import { PageRouter } from '../../router/PageRouter'
import { WebProccessExitPage } from './WebProccessExitPage'
import { router } from '@kit.ArkUI'
import { WebPage } from './WebPage'
import { WebHandleScrollPage } from './WebHandleScrollPage'
import { WebKeyboardTestPage } from './WebKeyboardTestPage'
import { WebShowWindowPage } from './WebShowWindowPage'
import { WebPageLoadPage } from './WebPageLoadPage'
import { WebViewNestedScrollPage } from './WebViewNestedScrollPage'
import { WebUploadPage } from './WebUploadPage'
import { WebDownloadPage } from './WebDownloadPage'
import { WebMediaPage } from './WebMediaPage'

@Entry({ routeName: PageRouter.PAGE_WEB })
@Component
export struct ArkWebPage {
  scroller: Scroller = new Scroller()

  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB,
    }, router.RouterMode.Single)
  }

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        Button('Web网页的加载')
          .onClick(() => {
            WebPageLoadPage.startPage()
          })
        Button('Web相关配置和操作')
          .onClick(() => {
            WebPage.startPage()
          })
        Button('Web组件上传能力')
          .onClick(() => {
            WebUploadPage.startPage()
          })
        Button('Web组件下载能力')
          .onClick(() => {
            WebDownloadPage.startPage()
          })
        Button('Web页面显示内容滚动')
          .onClick(() => {
            WebHandleScrollPage.startPage()
          })
        Button('Web页面嵌套滚动')
          .onClick(() => {
            WebViewNestedScrollPage.startPage()
          })
        Button('处理Web渲染进程异常退出问题')
          .onClick(() => {
            WebProccessExitPage.startPage()
          })
        Button('Web组件对接软键盘')
          .onClick(() => {
            WebKeyboardTestPage.startPage()
          })
        Button('使用Web组件显示网页弹框')
          .onClick(() => {
            WebShowWindowPage.startPage()
          })
        Button('Web中打开摄像头和麦克风')
          .onClick(() => {
            WebMediaPage.startPage()
          })
      }.width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
    }.width('100%')
  }
}