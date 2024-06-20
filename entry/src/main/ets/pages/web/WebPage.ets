import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import { CommonButton, RadioList } from '../component/MyComponent';

@Entry
@Component
struct WebPage {
  private param: object = router.getParams()
  webUrl: string = this.param?.['web_url']
  webViewController: web_webview.WebviewController = new web_webview.WebviewController()
  //webView属性
  @State private darkMode: WebDarkMode = WebDarkMode.Off
  @State private forceDarkAccess: boolean = false

  build() {
    Column() {
      Web({ src: 'https://www.baidu.com', controller: this.webViewController })
        .width('100%')
        .darkMode(this.darkMode)
        .forceDarkAccess(this.forceDarkAccess)
        .height(400)
        .enabled(true)
        .focusable(true)
        .touchable(true)
        .onShowFileSelector((event) => {
          // let fileResult = event.result

          return true
        })
      Divider().color(Color.Black).height('2vp').width('100%')
      Button('加载网页')
        .onClick(() => {
          try {
            this.webViewController.loadUrl(this.param['web_url'])
          } catch (e) {
            console.debug('===加载网页失败' + e)
          }
        })
      Button('加载本地网页')
        .onClick(() => {
          try {
            this.webViewController.loadUrl($rawfile('localh5.html'))
          } catch (e) {
            console.debug('===加载网页失败' + e)
          }
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
      })
      Checkbox() {
        Text('是否开启强制深色模式')
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
    .height('100%')
  }
}