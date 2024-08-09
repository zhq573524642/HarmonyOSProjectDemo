import router from '@ohos.router';
import { CommonButton, RadioList } from '../component/MyComponent';

import { BusinessError } from '@kit.BasicServicesKit';
import { webview } from '@kit.ArkWeb';

class TestClass {
  test(): string {
    console.debug('===H5调用无参函数')
    return '原生传给H5的数据:test'
  }

  testWithParam(name: string): string {
    console.debug('===H5调用传参函数:' + name)
    return '原生传给H5的数据:testWithParam'
  }
}

@Entry
@Component
struct WebPage {
  private scroller: Scroller = new Scroller()
  private param: object = router.getParams()
  webUrl: string = this.param?.['web_url']
  webViewController: webview.WebviewController = new webview.WebviewController()
  responseWeb: WebResourceResponse = new WebResourceResponse()
  heads: Header[] = new Array();
  //webView属性
  @State private darkMode: WebDarkMode = WebDarkMode.Off
  @State private forceDarkAccess: boolean = false
  @State cacheMode: CacheMode = CacheMode.Default
  dialogController: CustomDialogController | null = null;
  @State webData: string = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head>\n" +
    "<title>intercept test</title>\n" +
    "</head>\n" +
    "<body>\n" +
    "<h1>intercept test</h1>\n" +
    "</body>\n" +
    "</html>";
  @State testClass: TestClass = new TestClass()
  //数据通道端口
  ports: webview.WebMessagePort[] = [];
  @State sendToH5: string = '这是发给H5的消息'
  @State receiveFromH5: string = '这是来自H5的消息'
  pdfPageNum: number = 1

  aboutToAppear(): void {
    try {
      webview.WebviewController.setWebDebuggingAccess(true);
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  build() {
    Column({ space: 10 }) {
      Web({ src: 'https://www.baidu.com', controller: this.webViewController })
        .width('100%')
        .cacheMode(this.cacheMode)//缓存模式
        .darkMode(this.darkMode)//深色模式
        .forceDarkAccess(this.forceDarkAccess)//是否强制打开深色模式
        .javaScriptAccess(true)
        .multiWindowAccess(true)//是否允许网页在新窗口打开
        .allowWindowOpenMethod(true)//接口设置为true时，前端页面通过JavaScript函数调用的方式打开新窗口。
        .domStorageAccess(true)//预览pdf需开启文档对象模型存储权限
        .height(400)
        .enabled(true)
        .focusable(true)
        .touchable(true)
        .javaScriptProxy({
          object: this.testClass,
          name: 'nativeCall',
          methodList: ['test', 'testWithParam'],
          controller: this.webViewController
        })
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
        .onShowFileSelector((event) => {
          // let fileResult = event.result
          return false
        })
        .onControllerAttached(() => {
          console.debug('===onControllerAttached')
        })
        .onLoadIntercept((event) => {
          if (event) {
            console.debug('===onLoadIntercept-url' + event.data.getRequestUrl())
            console.debug('===onLoadIntercept-method' + event.data.getRequestMethod())
            console.debug('===onLoadIntercept-header' + JSON.stringify(event.data.getRequestHeader()))
            console.debug('===onLoadIntercept-isRequestGesture' + event.data.isRequestGesture())
            console.debug('===onLoadIntercept-isMainFrame' + event.data.isMainFrame())
            console.debug('===onLoadIntercept-isRedirect' + event.data.isRedirect())
            let url: string = event.data.getRequestUrl();
            if (url.indexOf('native://') === 0) {
              // 跳转其他界面
              router.pushUrl({ url: 'pages/ui/arkts/ArkTSBasePage' });
              return true;
            }
          }
          return false
        })
        .onOverrideUrlLoading((event) => {
          if (event && event.getRequestUrl() == 'about:blank') {
            return true
          }
          return false
        })
        .onInterceptRequest((event) => {
          if (event) {
            console.debug('===onInterceptRequest-url:' + event.request.getRequestUrl())
          }
          let head1: Header = {
            headerKey: "Connection",
            headerValue: "keep-alive"
          }
          let head2: Header = {
            headerKey: "Cache-Control",
            headerValue: "no-cache"
          }
          let length = this.heads.push(head1);
          length = this.heads.push(head2);
          this.responseWeb.setResponseHeader(this.heads);
          this.responseWeb.setResponseData(this.webData);
          this.responseWeb.setResponseEncoding('utf-8');
          this.responseWeb.setResponseMimeType('text/html');
          this.responseWeb.setResponseCode(200);
          this.responseWeb.setReasonMessage('OK');
          // 返回响应数据则按照响应数据加载，无响应数据则返回null表示按照原来的方式加载
          // return this.responseWeb
          return null
        })
        .onPageBegin((event) => {
          console.debug('===onPageBegin：' + event?.url)
        })
        .onProgressChange((event) => {
          console.debug('===onProgressChange:' + event?.newProgress)
        })
        .onPageEnd((event) => {
          console.debug('===onPageEnd：' + event?.url)
          this.initMessagePort()
          //预加载网页
          this.webViewController.prefetchPage('https://www.wanandroid.com/')
        })
        .onPageVisible((event) => {
          console.debug('===onPageVisible:' + event.url)
        })
        .onRenderExited((event) => {
          if (event) {
            console.debug('===onRenderExited:' + event.renderExitReason)
          }
        })
        .onFirstContentfulPaint((event) => {
          console.debug('===onFirstContentfulPaint:' + event?.navigationStartTick + '--' +
            event?.firstContentfulPaintMs)
        })
        .onFirstMeaningfulPaint((event) => {
          console.debug('===onFirstMeaningfulPaint:' + event.navigationStartTime + '--' +
          event.firstMeaningfulPaintTime)
        })
        .onLargestContentfulPaint((event) => {
          console.debug('===onLargestContentfulPaint:')
        })

      Divider().color(Color.Black).height('2vp').width('100%')
      Scroll(this.scroller) {
        Column({ space: 6 }) {
          Row({ space: 10 }) {
            Button('网页后退').onClick(() => {
              if (this.webViewController.accessBackward()) {
                this.webViewController.backward()
              }
            })

            Button('网页前进').onClick(() => {
              if (this.webViewController.accessForward()) {
                this.webViewController.forward()
              }
            })
          }

          Button('设置前进后退网页缓存配置')
            .onClick(() => {
              // let options = new webview.BackForwardCacheOptions();
              // options.size = 10;
              // options.timeToLive = 300;
              // this.webViewController.setBackForwardCacheOptions(options);
            })
          Button('加载网页')
            .onClick(() => {
              try {
                this.webViewController.loadUrl(this.param['web_url'])
              } catch (e) {
                console.debug('===加载网页失败' + e)
              }
            })
          Button('加载本地网页:选择文件')
            .onClick(() => {
              try {
                this.webViewController.loadUrl($rawfile('localh5.html'))
              } catch (e) {
                console.debug('===加载网页失败' + e)
              }
            })
          Button('加载本地网页:在新窗口中打开')
            .onClick(() => {
              try {
                this.webViewController.loadUrl($rawfile('multiWindowH5.html'))
              } catch (e) {
                console.debug('===加载网页失败' + e)
              }
            })
          Button('加载本地网页:访问地理位置')
            .onClick(() => {
              try {
                this.webViewController.loadUrl($rawfile('locationH5.html'))
              } catch (e) {
                console.debug('===加载网页失败' + e)
              }
            })
          Text('App调用Js').fontSize(18).fontWeight(FontWeight.Bold)
          Button('加载本地网页:App调用JS')
            .onClick(() => {
              try {
                this.webViewController.loadUrl($rawfile('appToJsH5.html'))
              } catch (e) {
                console.debug('===加载网页失败' + e)
              }
            })
          Row() {
            Button('调用htmlTest无参')
              .onClick(() => {
                this.webViewController.runJavaScript('htmlTest()')
              })
            Button('调用htmlTest传参')
              .onClick(() => {
                this.webViewController.runJavaScript('htmlTest(param)')
              })
          }

          Button('runJavaScriptCodePassed')
            .onClick(() => {
              // 传递runJavaScript侧代码方法。
              this.webViewController.runJavaScript(`function changeColor(){document.getElementById('text').style.color = 'red'}`);
            })
          Text('Js调用App').fontSize(18).fontWeight(FontWeight.Bold)
          Button('加载本地网页：JS调用App')
            .onClick(() => {
              try {
                this.webViewController.loadUrl($rawfile('H5toApp.html'))
              } catch (e) {
                console.debug('===加载网页失败' + e)
              }
            })
          Text('H5跳转原生页面').fontSize(18).fontWeight(FontWeight.Bold)
          Button("加载本地网页：H5跳转原生页面").onClick(() => {
            try {
              this.webViewController.loadUrl($rawfile('H5RouterApp.html'))
            } catch (e) {
              console.debug('===加载网页失败' + e)
            }
          })
          Text('App和JS建立数据通道').fontSize(18).fontWeight(FontWeight.Bold)
          Button("加载本地网页：App和JS简历数据通道").onClick(() => {
            try {
              this.webViewController.loadUrl($rawfile('appH5MsgByPort.html'))
            } catch (e) {
              console.debug('===加载网页失败' + e)
            }
          })
          Text(`来自H5：${this.receiveFromH5}`).fontSize(15).fontColor(Color.Red)
          TextInput({ placeholder: '请输入', text: $$this.sendToH5 }).width('80%').height(45)
          Button('App给H5发送消息').onClick(() => {
            this.sendMsgToH5()
          })
          Button('WebView嵌套滚动')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/web/WebViewNestedScrollPage'
              })
            })
          Button('打开动态创建Web组件')
            .onClick(() => {

            })
          Text('网页预解析、预连接、预解析').fontSize(18).fontWeight(FontWeight.Bold)
          //在EntryAbility的onCreate中进行预解析预连接
          Button('打开预解析、预连接的网页')
            .onClick(() => {
              this.webViewController.loadUrl('https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-models-V5')
            })
          Button('打开预加载的网页')
            .onClick(() => {
              this.webViewController.loadUrl('https://www.wanandroid.com/')
            })
          Text('加载pdf文件').fontSize(18).fontWeight(FontWeight.Bold)
          Button('打开应用内资源pdf')
            .onClick(() => {
              this.webViewController.loadUrl($rawfile('book2019.pdf'))
            })

          RadioList({
            title: 'CacheMode',
            checkedIndex: 0,
            radioGroup: 'CacheMode',
            data: ['Default', 'None', 'Online', 'Only'],
            onCheckChange: (position: number, isChecked: boolean) => {
              if (position === 0 && isChecked) {
                this.cacheMode = CacheMode.Default
              }
              if (position === 1 && isChecked) {
                this.cacheMode = CacheMode.None
              }
              if (position === 2 && isChecked) {
                this.cacheMode = CacheMode.Online
              }
              if (position === 3 && isChecked) {
                this.cacheMode = CacheMode.Only
              }

            }
          }).margin({ left: 10 })
          RadioList({
            title: 'DarkMode',
            checkedIndex: 0,
            radioGroup: 'DarkMode',
            data: ['Off', 'On', 'Auto'],
            onCheckChange: (position: number, isChecked: boolean) => {
              if (position == 0 && isChecked) {
                this.darkMode = WebDarkMode.Off
              }
              if (position == 1 && isChecked) {
                this.darkMode = WebDarkMode.On
              }
              if (position == 2 && isChecked) {
                this.darkMode = WebDarkMode.Auto
              }
            }
          }).margin({ left: 10 })
          Checkbox() {
            Text('是否开启强制深色模式')
              .visibility(this.darkMode === WebDarkMode.On ? Visibility.Visible : Visibility.None)
          }
          .select(this.forceDarkAccess)
          .selectedColor(Color.Red)
          .onChange((isSelected: boolean) => {
            this.forceDarkAccess = isSelected
          })
          .width(30)
          .height(30)
          .visibility(this.darkMode === WebDarkMode.On ? Visibility.Visible : Visibility.None)
        }.width('100%')
      }.width('100%')
      .layoutWeight(1)

    }.width('100%')
    .height('100%')

  }

  initMessagePort() {
    try {
      // 1、创建两个消息端口。
      this.ports = this.webViewController.createWebMessagePorts();
      // 2、在应用侧的消息端口(如端口1)上注册回调事件。
      this.ports[1].onMessageEvent((result: webview.WebMessage) => {
        let msg = 'Got msg from HTML:';
        if (typeof (result) === 'string') {
          console.info(`received string message from html5, string is: ${result}`);
          msg = msg + result;
        } else if (typeof (result) === 'object') {
          if (result instanceof ArrayBuffer) {
            console.info(`received arraybuffer from html5, length is: ${result.byteLength}`);
            msg = msg + 'lenght is ' + result.byteLength;
          } else {
            console.info('not support');
          }
        } else {
          console.info('not support');
        }
        this.receiveFromH5 = msg;
      })
      // 3、将另一个消息端口(如端口0)发送到HTML侧，由HTML侧保存并使用。
      this.webViewController.postMessage('__init_port__', [this.ports[0]], '*');
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  sendMsgToH5() {

    try {
      if (this.ports && this.ports[1]) {
        this.ports[1].postMessageEvent(this.sendToH5);
      } else {
        console.error(`ports is null, Please initialize first`);
      }
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }
}

// 在同一page页有两个Web组件。在WebComponent新开窗口时，会跳转到NewWebViewComp。
@CustomDialog
struct NewWebViewComp {
  controller?: CustomDialogController;
  webviewController1: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {
      Web({ src: "", controller: this.webviewController1 })
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
