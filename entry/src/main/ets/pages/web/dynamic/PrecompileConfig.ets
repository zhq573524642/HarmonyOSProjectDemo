
import { webview } from '@kit.ArkWeb'

export interface Config {
  url:  string,
  localPath: string, // 本地资源路径
  options: webview.CacheOptions
}

export let configs: Array<Config> = [
  {
    url: "https://www.example.com/example.js",
    localPath: "example.js",
    options: {
      responseHeaders: [
        { headerKey: "E-Tag", headerValue: "aWO42N9P9dG/5xqYQCxsx+vDOoU="},
        { headerKey: "Last-Modified", headerValue: "Wed, 21 Mar 2024 10:38:41 GMT"}
      ]
    }
  }
]