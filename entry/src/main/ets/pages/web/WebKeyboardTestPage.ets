import { webview } from "@kit.ArkWeb"
import { PageRouter } from "../../router/PageRouter"
import { router } from "@kit.ArkUI"

@Entry({ routeName: PageRouter.PAGE_WEB_KEYBOARD })
@Component
export struct WebKeyboardTestPage {
  //设置Web组件的键盘避让方式
  //一、EntryAbility中windowStage.loadContent后设置
  // 设置虚拟键盘抬起时压缩页面大小为减去键盘的高度
  //windowStage.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
  //获取键盘避让方式
  // let keyboardAvoidMode = windowStage.getMainWindowSync().getUIContext().getKeyboardAvoidMode();
  //Resize模式下，应用窗口高度可缩小避开软键盘，ArkWeb组件跟随ArkUI重新布局。（窗口调整大小）
  //Offset模式下（以及默认模式），应用窗口高度不变，ArkWeb组件根据自身的避让模式进行避让。（Web组件向上移动）

  //二、
  //当KeyboardAvoidMode.OFFSET时，通过调用Web组件的keyboardAvoidMode方法设置Web组件的键盘避让方式
  //RESIZE_VISUAL：仅调整可视视口的大小，而不调整布局视口的大小。
  //RESIZE_CONTENT：调整视觉视口和布局视口的大小。
  //OVERLAYS_CONTENT：不调整任何视口的大小，获焦input元素没有滚动到可识区域的行为。

  //三、设置Web组件的安全区域
  // .expandSafeArea([SafeAreaType.KEYBOARD,SafeAreaType.SYSTEM])
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_KEYBOARD
    }, router.RouterMode.Single)
  }

  webController: webview.WebviewController = new webview.WebviewController()

  build() {
    Column() {
      Column()
        .backgroundColor(Color.Green)
        .height('40%')
        .width('100%')
      Web({ src: $rawfile('H5KeyboardTest.html'), controller: this.webController })// .zoomAccess(false)
        // .keyboardAvoidMode(WebKeyboardAvoidMode.RESIZE_VISUAL)
        .expandSafeArea([SafeAreaType.KEYBOARD, SafeAreaType.SYSTEM])
        .onScaleChange((event) => {
          console.log('===onScaleChange changed from ' + event.oldScale + ' to ' + event.newScale);
        }).width('100%')
        .height('100%')
    }.width('100%')
    .height('100%')
  }
}