import { webview } from '@kit.ArkWeb'

export class WebViewManager {
  static instance: WebViewManager = new WebViewManager()

  static configCookieSync(url: string, value: string, incognito?: boolean) {
    try {
      webview.WebCookieManager.configCookieSync(url, value, incognito)
    } catch (e) {
    }
  }
}