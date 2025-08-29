import { PageRouter } from "../../router/PageRouter";
import { webview } from "@kit.ArkWeb";
import { BusinessError } from "@kit.BasicServicesKit";
import { router } from "@kit.ArkUI";

@Entry({ routeName: PageRouter.PAGE_WEB_PAGE_LOAD })
@Component
export struct WebPageLoadPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_PAGE_LOAD
    }, router.RouterMode.Single)
  }

  @State webUrl: string = 'https://www.baidu.com'
  webController: webview.WebviewController = new webview.WebviewController()
  htmlData: string = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head>\n" +
    "<title>intercept test</title>\n" +
    "</head>\n" +
    "<body>\n" +
    "<h1>这是Html的文本数据啊</h1>\n" +
    "</body>\n" +
    "</html>";
  dialogController: CustomDialogController | null = null;

  build() {
    Column({ space: 10 }) {
      Web({ src: this.webUrl, controller: this.webController })
        .multiWindowAccess(true)//是否允许网页在新窗口打开
          //在新窗口中打开网页
        .onWindowNew((event) => {
          if (this.dialogController) {
            this.dialogController.close()
          }
          //新的controller
          let popController: webview.WebviewController = new webview.WebviewController();
          this.dialogController = new CustomDialogController({
            builder: NewWebViewComp({ webviewController1: popController })
          })
          this.dialogController.open();
          // 将新窗口对应WebviewController返回给Web内核。
          // 如果不需要打开新窗口请调用event.handler.setWebController接口设置成null。
          // 若不调用event.handler.setWebController接口，会造成render进程阻塞。
          event.handler.setWebController(popController);
        })
        .width('100%')
        .layoutWeight(1)
      Button('加载网页：loadUrl')
        .onClick(() => {
          try {
            this.webController.loadUrl('https://www.runoob.com/html/html-elements.html')
          } catch (e) {
            let error = e as BusinessError
            console.debug('===加载网页失败：' + error.message)
          }
        })
      Button('加载本地页面$rawfile(xxx)')
        .onClick(() => {
          try {
            this.webController.loadUrl($rawfile('localh5.html'))
          } catch (e) {
            let error = e as BusinessError
            console.debug('===加载网页失败：' + error.message)
          }
        })
      Button('加载本地页面resource://rawfile/xxx.html')
        .onClick(() => {
          try {
            this.webController.loadUrl('resource://rawfile/localh5.html')
          } catch (e) {
            let error = e as BusinessError
            console.debug('===加载网页失败：' + error.message)
          }
        })

      Button('加载本地网页:在新窗口中打开')
        .onClick(() => {
          try {
            this.webController.loadUrl($rawfile('multiWindowH5.html'))
          } catch (e) {
            console.debug('===加载网页失败' + e)
          }
        })
      Button('加载沙箱路径下的本地页面文件')
        .onClick(() => {

        })
      Button('加载HTML格式的文本数据')
        .onClick(() => {
          try {
            this.webController.loadData(this.htmlData, "text/html",
              "UTF-8")
          } catch (e) {
            let error = e as BusinessError
            console.debug('===加载网页失败：' + error.message)
          }
        })
    }.width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(15)
    .height('100%')
  }
}

// 在同一page页有两个Web组件。在WebComponent新开窗口时，会跳转到NewWebViewComp。
@CustomDialog
struct NewWebViewComp {
  controller?: CustomDialogController;
  webviewController1: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {
      Web({ src: "https://www.runoob.com/html/html-elements.html", controller: this.webviewController1 })
        .javaScriptAccess(true)
        .multiWindowAccess(false)
        .onWindowExit(() => {
          console.info("NewWebViewComp onWindowExit");
          if (this.controller) {
            this.controller.close();
          }
        })
    }
  }
}