import router from '@ohos.router';
import { CommonButton, CommonTitle, RadioList } from '../component/MyComponent';

import { BusinessError } from '@kit.BasicServicesKit';
import { webview } from '@kit.ArkWeb';
import { ToastUtils } from '@ohos/common';
import { call, data } from '@kit.TelephonyKit';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { PageRouter } from '../../router/PageRouter';

class TestClass {
  test(): string {
    console.debug('===H5调用无参函数')
    return '原生传给H5的数据:test'
  }

  testWithArray(): Array<number> {
    return [1, 2, 3, 4, 5, 6, 7]
  }

  testWithParam(name: string): string {
    console.debug('===H5调用传参函数:' + name)
    return '原生传给H5的数据:testWithParam'
  }

  testWithObject(name: string, age: number): Student {
    let student: Student = { name: name, age: age }
    return student
  }

  testToString(param: ESObject): string {
    return `信息：${param['name']}--${param['age']}`
  }

  testWithFunction(func: Function) {
    func('666')
  }

  testWithFunctionInH5Object(param: ESObject): void {
    console.debug('===调用成功：' + param)
    param.helloCall('123456')
  }

  toString(param: string): string {
    console.debug('===转换：' + param)
    return '转换：' + param
  }
}

class Student {
  name: string = ''
  age: number = 0
}

//1.Web进程 https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/web_component_process
//

@Entry({ routeName: PageRouter.PAGE_WEB_HANDLE })
@Component
export struct WebPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_HANDLE
    }, router.RouterMode.Single)
  }

  private scroller: Scroller = new Scroller()
  private param: object = router.getParams()
  uiContext = this.getUIContext()
  webUrl: string = this.param?.['web_url']
  webViewController: webview.WebviewController = new webview.WebviewController()
  //相应资源数据
  responseWeb: WebResourceResponse = new WebResourceResponse()
  //Header数组
  heads: Header[] = new Array();
  //webView属性
  @State private darkMode: WebDarkMode = WebDarkMode.Off
  @State private forceDarkAccess: boolean = false
  @State cacheMode: CacheMode = CacheMode.Default
  @State webData: string = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head>\n" +
    "<title>intercept test</title>\n" +
    "</head>\n" +
    "<body>\n" +
    "<h1>intercept test111111111111111111111</h1>\n" +
    "</body>\n" +
    "</html>";
  @State testClass: TestClass = new TestClass()
  //数据通道端口
  ports: webview.WebMessagePort[] = [];
  @State sendToH5: string = '这是发给H5的消息'
  @State receiveFromH5: string = '这是来自H5的消息'
  pdfPageNum: number = 1
  prefetchPageUrl: string = 'https://www.wanandroid.com/'
  preparePageUrl: string = 'https://www.runoob.com/java/java-tutorial.html'

  aboutToAppear(): void {
    try {
      webview.WebviewController.setWebDebuggingAccess(true);
    } catch (error) {
      console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
    }
  }

  build() {
    Column({ space: 10 }) {
      //incognitoMode 是否开启隐私模式
      Web({
        src: 'https://ohpm.openharmony.cn/#/cn/result?q=ohos',
        controller: this.webViewController,
        incognitoMode: false
      })
        .width('100%')
        .cacheMode(this.cacheMode)//缓存模式
        .darkMode(this.darkMode)//深色模式
        .forceDarkAccess(this.forceDarkAccess)//是否强制打开深色模式
        .javaScriptAccess(true)
        .multiWindowAccess(true)//是否允许网页在新窗口打开
        .allowWindowOpenMethod(true)//接口设置为true时，前端页面通过JavaScript函数调用的方式打开新窗口。
        .domStorageAccess(true)//预览pdf需开启文档对象模型存储权限
        .geolocationAccess(true)//允许获取位置信息
        .height(400)
        .enabled(true)
        .focusable(true)
        .touchable(true)
        .javaScriptProxy({
          object: this.testClass,
          name: 'nativeCall', //调用原生的代理名称
          methodList: ['test', 'testWithParam', 'testWithArray', 'testWithObject', 'testToString',
            'testWithFunction', 'toString'],
          controller: this.webViewController,
          // asyncMethodList:[]
          // permission:''
        })
        .onShowFileSelector((event) => {
          // let fileResult = event.result
          return false
        })//（1）webController进行绑定，禁止在该事件回调前调用Web组件相关的接口
        .onControllerAttached(() => {
          console.debug('===onControllerAttached')
          //设置自定义的User-Agent
          let defaultUserAgent = this.webViewController.getUserAgent()
          let customUserAgent = defaultUserAgent + 'agent-myCustomUserAgent'
          this.webViewController.setCustomUserAgent(customUserAgent)

        })//（2）当Web组件加载url之前触发该回调，用于判断是否阻止此次访问。默认允许加载。
        .onLoadIntercept((event) => {
          if (event) {
            console.debug('===onLoadIntercept-url：' + event.data.getRequestUrl())
            console.debug('===onLoadIntercept-method：' + event.data.getRequestMethod())
            console.debug('===onLoadIntercept-header：' + JSON.stringify(event.data.getRequestHeader()))
            console.debug('===onLoadIntercept-isRequestGesture：' + event.data.isRequestGesture())
            console.debug('===onLoadIntercept-isMainFrame：' + event.data.isMainFrame())
            console.debug('===onLoadIntercept-isRedirect：' + event.data.isRedirect())
            let url: string = event.data.getRequestUrl();
            if (url.indexOf('native://') === 0) {
              // 跳转其他界面
              router.pushUrl({ url: 'pages/ui/arkts/ArkTSBasePage' });
              return true;
            } else if (url.indexOf('tel://') === 0) {
              // 跳转拨号界面
              call.makeCall(url.substring(6), (err) => {
                if (!err) {
                  console.info('make call succeeded.');
                } else {
                  console.info('make call fail, err is:' + JSON.stringify(err));
                }
              });
              return true
            }
          }
          return false
        })//（3）当Web组件加载url之前触发该回调，用于拦截url并返回响应数据。
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
          this.webViewController.prefetchPage(this.prefetchPageUrl)
        })
        .onAppear(() => {
          // 指定第二个参数为true，代表要进行预连接，如果为false该接口只会对网址进行dns预解析
          // 第三个参数为要预连接socket的个数。最多允许6个。
          webview.WebviewController.prepareForPageLoad(this.preparePageUrl, true, 2);
        })
        .onOverrideUrlLoading((event) => {
          if (event && event.getRequestUrl() == 'about:blank') {
            return true
          }
          return false
        })
        .onPageVisible((event) => {
          console.debug('===onPageVisible:' + event.url)
        })//监听渲染进程退出事件
        .onRenderExited((event) => {
          if (event) {
            console.debug('===onRenderExited:' + event.renderExitReason)
          }
        })//FCP(First Contentful Paint)首次内容绘制
        .onFirstContentfulPaint((event) => {
          console.debug('===onFirstContentfulPaint:' + event?.navigationStartTick + '--' +
            event?.firstContentfulPaintMs)
        })//FMP(First Meaningful Paint)首次有效绘制
        .onFirstMeaningfulPaint((event) => {
          console.debug('===onFirstMeaningfulPaint:' + event.navigationStartTime + '--' +
          event.firstMeaningfulPaintTime)
        })//LCP(Largest Contentful Paint)最大内容绘制
        .onLargestContentfulPaint((event) => {
          console.debug('===onLargestContentfulPaint:')
        })
        .onRenderProcessNotResponding((data) => {
          console.debug('===onRenderProcessNotResponding：reason:' + data.reason.toString()
            + '--jsStack:' + data.jsStack)
        })
        .onRenderProcessResponding(() => {
          console.debug('===onRenderProcessResponding')
        })//H5访问获取位置信息
        .onGeolocationShow((event) => {
          //Web组件通过弹窗的形式通知应用侧位置权限请求消息。
          this.uiContext.showAlertDialog({
            title: '位置权限请求',
            message: '是否允许位置权限？',
            primaryButton: {
              value: '取消',
              action: () => {
                event.geolocation.invoke(event.origin, false, false)
              }
            },
            secondaryButton: {
              value: '确定',
              action: () => {
                event.geolocation.invoke(event.origin, true, false)
              }
            },
            cancel: () => {
              event.geolocation.invoke(event.origin, false, false)
            }
          })
        })
        .onGeolocationHide(() => {
          console.debug('===onGeolocationHide')
        })


      Divider().color(Color.Black).height('2vp').width('100%')
      Scroll(this.scroller) {
        Column({ space: 6 }) {
          CommonTitle({ title: '网页操作' })
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
              //设置Web组件可以缓存的最大数量为10，每个页面在缓存中停留300s。
              let options = new webview.BackForwardCacheOptions();
              options.size = 10;
              options.timeToLive = 300;
              this.webViewController.setBackForwardCacheOptions(options);
            })

          CommonTitle({ title: '渲染进程模式' })
          Button('获取渲染进程模式')
            .onClick(() => {
              let mode = webview.WebviewController.getRenderProcessMode()
              ToastUtils.show(mode == 0 ? '单进程' : '多进程')
            })
          Button('设置渲染进程模式')
            .onClick(() => {
              let mode = webview.WebviewController.getRenderProcessMode()
              try {
                if (mode === 0) {
                  webview.WebviewController.setRenderProcessMode(webview.RenderProcessMode.MULTIPLE)
                  ToastUtils.show('设置为多进程')
                } else {
                  webview.WebviewController.setRenderProcessMode(webview.RenderProcessMode.SINGLE)
                  ToastUtils.show('设置为单进程')
                }
              } catch (e) {
                let error = e as BusinessError
                console.error('===设置渲染进程异常：' + error.code + '--' + error.message)
              }
            })
          Button('关闭渲染进程')
            .onClick(() => {
              let result = this.webViewController.terminateRenderProcess()
              ToastUtils.show(`结果：${result}`)
            })

          CommonTitle({ title: 'User-Agent设置和获取' })
          Button('获取默认User-Agent')
            .onClick(() => {
              let userAgent = this.webViewController.getUserAgent()
              console.debug('===默认User-Agent：' + userAgent)
            })
          Text('在onControllerAttached回调中设置自定义User-Agent')
          Button('获取自定义User-Agent')
            .onClick(() => {
              let userAgent = this.webViewController.getCustomUserAgent()
              console.debug('===自定义User-Agent：' + userAgent)
            })
          CommonTitle({ title: '权限申请和位置信息获取' })

          Button('申请位置权限')
            .onClick(() => {
              // 向用户请求位置权限设置。
              let atManager = abilityAccessCtrl.createAtManager();
              let context: Context | undefined = this.getUIContext().getHostContext() as common.UIAbilityContext;
              atManager.requestPermissionsFromUser(context, ["ohos.permission.APPROXIMATELY_LOCATION"]).then((data) => {
                console.info('data:' + JSON.stringify(data));
                console.info('data permissions:' + data.permissions);
                console.info('data authResults:' + data.authResults);
              }).catch((error: BusinessError) => {
                console.error(`Failed to request permissions from user. Code is ${error.code}, message is ${error.message}`);
              })
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
            Button('调用htmlTestParam传参')
              .onClick(() => {
                this.webViewController.runJavaScript('htmlTestParam("123456")')
              })
          }

          Button('加载本地网页:App调用JS中Object中的Function')
            .onClick(() => {
              try {
                this.webViewController.loadUrl($rawfile('appToH5FuncInObject.html'))
              } catch (e) {
                console.debug('===加载网页失败' + e)
              }
            })
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
          Button('1.Web组件使用javaScriptProxy接口')
          Button('2.使用registerJavaScriptProxy')
            .onClick(() => {
              try {
                this.webViewController.registerJavaScriptProxy(this.testClass, "nativeCall",
                  ['testWithFunctionInH5Object'])

              } catch (e) {
                let error = e as BusinessError
                console.error('===异常：' + error.message)
              }
            })
          Button('刷新网页')
            .onClick(() => {
              this.webViewController.refresh()
            })
          Button('3.移除deleteJavaScriptRegister')
            .onClick(() => {
              try {
                this.webViewController.deleteJavaScriptRegister('nativeCall')
              } catch (e) {
                let error = e as BusinessError
                console.error('===异常：' + error.message)
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

          CommonTitle({ title: '网页预解析、预连接、预解析' })
          //在EntryAbility的onCreate中进行预解析预连接
          //webview.WebviewController.initializeWebEngine()
          //     webview.WebviewController.prepareForPageLoad('https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-models-V5',
          //       true, 2)
          Button('打开预解析、预连接的网页:EntryAbility中')
            .onClick(() => {
              this.webViewController.loadUrl('https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-models-V5')
            })
          Button('打开预解析、预连接的网页:Web组件的onAppear回调中')
            .onClick(()=>{
              this.webViewController.loadUrl(this.preparePageUrl)
            })
          Button('打开预加载的网页')
            .onClick(() => {
              this.webViewController.loadUrl(this.prefetchPageUrl)
            })
          Text('加载pdf文件').fontSize(18).fontWeight(FontWeight.Bold)
          Button('打开应用内资源pdf')
            .onClick(() => {
              this.webViewController.loadUrl($rawfile('book2019.pdf'))
            })

          CommonTitle({ title: '缓存：Cache和DomStorage' })
          //1.Cache
          //Default：优先使用未过期的缓存。如果缓存不存在，则从网络获取。
          //
          // None：加载资源使用缓存。如果缓存中无该资源，则从网络中获取。
          //
          // Online：加载资源不使用缓存。全部从网络中获取。
          //
          // Only：只从缓存中加载资源。
          //2.Dom Storage包含了Session Storage和Local Storage两类。
          // Session Storage为临时数据，其存储与释放跟随会话生命周期；Local Storage为持久化数据，保存在应用目录下。
          //通过 Web组件的domStorageAccess(true)方法设置
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
          Button('清除缓存')
            .onClick(() => {
              //清楚缓存，是否rom和ram的缓存都清楚，false只清除ram
              this.webViewController.removeCache(true)
            })
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
        let msg = '';
        if (typeof (result) === 'string') {
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


