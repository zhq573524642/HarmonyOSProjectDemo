import { PageRouter } from "../../router/PageRouter";
import { router } from "@kit.ArkUI";
import { webview } from "@kit.ArkWeb";

@Entry({ routeName: PageRouter.PAGE_WEB_HANDLE_SCROLL })
@Component
export struct WebHandleScrollPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_HANDLE_SCROLL
    }, router.RouterMode.Single)
  }

  webController: webview.WebviewController = new webview.WebviewController()
  @State targetFactor: number = 1;
  @State pageFactor: number = 100;

  build() {
    Column({ space: 5 }) {
      Web({ src: 'https://www.runoob.com/html/html-elements.html', controller: this.webController })
        .width('100%')
        .zoomAccess(true)
        .layoutWeight(1)
        .onScaleChange((event) => {
          //获取当前的缩放比例
          this.pageFactor = event.newScale
        })
      Button('滚动到顶部:scrollTo(0.0)')
        .onClick(() => {
          this.webController.scrollTo(0, 0)
        })
      Row() {
        Button('pageUp(true)')
          .onClick(() => {
            this.webController.pageUp(true)
          })
        Button('pageUp(false)')
          .onClick(() => {
            this.webController.pageUp(false)
          })
      }

      Row() {
        Button('pageDown(true)')
          .onClick(() => {
            this.webController.pageDown(true)
          })
        Button('pageDown(false)')
          .onClick(() => {
            this.webController.pageDown(false)
          })
      }

      Row() {
        Button('zoomIn放大25%')
          .onClick(() => {
            this.webController.zoomIn()
          })
        Button('zoomOut缩小20%')
          .onClick(() => {
            this.webController.zoomOut()
          })
      }

      Row() {
        Button('zoom:2')
          .onClick(() => {
            this.webController.zoom(2)
          })
        Button('zoom:0.5')
          .onClick(() => {
            this.webController.zoom(0.5)
          })
      }

      TextInput()
        .type(InputType.NUMBER_DECIMAL)
        .onChange((value) => {
          //输入的目标缩放比例
          this.targetFactor = Number(value);
        })
      Button('根据输入的比例进行按比例缩放')
        .onClick(() => {
          let factor = 100 * this.targetFactor / this.pageFactor
          this.webController.zoom(factor)
        })
    }
  }
}