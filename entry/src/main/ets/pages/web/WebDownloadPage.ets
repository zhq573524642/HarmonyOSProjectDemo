import { PageRouter } from "../../router/PageRouter";
import { router } from "@kit.ArkUI";
import { webview } from "@kit.ArkWeb";
import { ToastUtils } from "@ohos/common";
import { DownloadUtils } from "../../utils/DownloadUtils";
import { BusinessError } from "@kit.BasicServicesKit";
import { fileUri, picker } from "@kit.CoreFileKit";

@Entry({ routeName: PageRouter.PAGE_WEB_DOWNLOAD })
@Component
export struct WebDownloadPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_DOWNLOAD
    }, router.RouterMode.Single)
  }

  webController: webview.WebviewController = new webview.WebviewController()
  webDownloadDelegate: webview.WebDownloadDelegate = new webview.WebDownloadDelegate()
  webDownloadItem: webview.WebDownloadItem | null = null
  @State downloadGuid: string = '' //下载任务唯一标识
  @State progressIndex: number = 0 //下载进度
  @State downloadPath: string = '' //下载存储路径
  @State downloadSpeed: number = 0 //下载速度
  @State downloadStatus: string = '未下载' //下载状态描述
  @State totalBytesSize: number = 0; //下载文件大小
  @State isDownloading: boolean = false //是否正在下载
  @State defaultSavePath: string = '/data/storage/el2/base/cache/web/'
  @State fileName: string = ''
  // 用于记录失败的下载任务。
  failedData: Uint8Array = new Uint8Array();

  aboutToAppear(): void {
    DownloadUtils.init(this.getUIContext())
  }

  onBackPress(): boolean | void {
    try {
      if (this.webDownloadItem != null) {
        this.webDownloadItem.cancel()
      }
    } catch (e) {
    }
  }

  build() {
    Column({ space: 10 }) {
      Web({ src: $rawfile('H5Download.html'), controller: this.webController })
        .height(300)
        .width('100%')
      Text(`下载唯一标识：${this.downloadGuid}`)
        .fontSize(16)
      Text(`下载文件大小：${this.totalBytesSize}`)
        .fontSize(16)
      Text(`下载位置：${this.downloadPath}`)
        .fontSize(16)
      Text(`下载速度：${this.downloadSpeed} 字节/秒`)
        .fontSize(16)
      Text(`下载状态：${this.downloadStatus}`)
        .fontSize(16)
      Progress({ value: this.progressIndex, total: 100, type: ProgressType.Linear })
        .width(200).height(20)
        .style({ strokeWidth: 15, enableScanEffect: true })
        .color(Color.Green)
      Button('设置WebDownloadDelegate')
        .onClick(() => {
          try { //下载之前
            this.webDownloadDelegate.onBeforeDownload((webDownloadItem: webview.WebDownloadItem) => {
              // 传入一个下载路径，并开始下载。
              // 如果传入一个不存在的路径，则会下载到默认/data/storage/el2/base/cache/web/目录。
              this.webDownloadItem = webDownloadItem
              // 使用DocumentViewPicker()获取当前示例的默认下载目录，将该目录设置为下载目录
              getDownloadPathFromPicker().then((downloadPath) => {
                this.defaultSavePath = downloadPath
                this.fileName = webDownloadItem.getSuggestedFileName()
                let filePath = this.defaultSavePath + '/' + this.fileName
                this.downloadPath = filePath
                this.totalBytesSize = webDownloadItem.getTotalBytes()
                this.isDownloading = true
                this.downloadStatus = '开始下载'
                webDownloadItem.start(filePath);
              });
            })
            //下载过程
            this.webDownloadDelegate.onDownloadUpdated((webDownloadItem: webview.WebDownloadItem) => {
              this.webDownloadItem = webDownloadItem
              this.downloadStatus = '下载中...'
              this.isDownloading = true
              // 下载任务的唯一标识。
              this.downloadGuid = webDownloadItem.getGuid()
              // 下载的进度。
              this.progressIndex = webDownloadItem.getPercentComplete()
              // 当前的下载速度。
              this.downloadSpeed = webDownloadItem.getCurrentSpeed()
            })
            //下载结果
            this.webDownloadDelegate.onDownloadFailed((webDownloadItem: webview.WebDownloadItem) => {
              this.webDownloadItem = webDownloadItem
              // 下载任务失败的错误码。
              this.isDownloading = false
              this.downloadStatus = '下载失败：' + webDownloadItem.getLastErrorCode()
              this.failedData = webDownloadItem.serialize()
            })
            //下载结束
            this.webDownloadDelegate.onDownloadFinish((webDownloadItem: webview.WebDownloadItem) => {
              this.webDownloadItem = webDownloadItem
              this.downloadStatus = '下载结束'
              this.isDownloading = true
            })
            //设置下载代理
            this.webController.setDownloadDelegate(this.webDownloadDelegate)
            ToastUtils.show('设置下载代理成功')
          } catch (e) {
            let error = e as BusinessError
            console.debug('===失败：' + error.code + '--' + error.message)
          }
        })

      Button('手动开始下载')
        .onClick(() => {
          if (!this.isDownloading) {
            this.webController.startDownload('https://appcdn.yiboshi.com/app/yijiaowanjia_prod_App_202505260530_v3.2.1_79_release_321_jiagu_sign.apk')
          } else {
            ToastUtils.show('当前有任务正在下载')
          }
        })
      Row({ space: 10 }) {
        Button('暂停')
          .onClick(() => {
            try {
              if (this.webDownloadItem != null) {
                this.webDownloadItem.pause()
                this.isDownloading = false
              }
            } catch (e) {
              let error = e as BusinessError
              console.debug('===失败：' + error.code + '--' + error.message)
            }
          })
        Button('继续')
          .onClick(() => {
            try {
              if (this.webDownloadItem != null) {
                this.webDownloadItem.resume()
                this.isDownloading = true
              }
            } catch (e) {
              let error = e as BusinessError
              console.debug('===失败：' + error.code + '--' + error.message)
            }
          })
        Button('取消并保存下载进度')
          .onClick(() => {
            try {
              if (this.webDownloadItem != null) {
                DownloadUtils.saveDownloadInfo(DownloadUtils.uint8ArrayToStr(this.webDownloadItem.serialize()))
                this.webDownloadItem.cancel()
                this.isDownloading = false
              }
            } catch (e) {
              let error = e as BusinessError
              console.debug('===失败：' + error.code + '--' + error.message)
            }
          })

        Button('继续下载')
          .onClick(() => {
            console.debug('===文件：'+this.defaultSavePath+"--"+this.fileName)
            try { // 当前默认持久化文件存在，用户根据实际情况增加判断。
              let webDownloadItem =
                webview.WebDownloadItem.deserialize(DownloadUtils.strToUint8Array(DownloadUtils.readFileSync(this.defaultSavePath,
                  this.fileName)));
              webview.WebDownloadManager.resumeDownload(webDownloadItem);
            } catch (e) {
              let error = e as BusinessError
              console.debug('===失败：' + error.code + '--' + error.message)
            }
          })
      }
    }.width('100%')
    .height('100%')
  }
}

function getDownloadPathFromPicker(): Promise<string> {
  return new Promise<string>(resolve => {
    try {
      const documentSaveOptions = new picker.DocumentSaveOptions();
      documentSaveOptions.pickerMode = picker.DocumentPickerMode.DOWNLOAD
      const documentPicker = new picker.DocumentViewPicker();
      documentPicker.save(documentSaveOptions).then(async (documentSaveResult: Array<string>) => {
        if (documentSaveResult.length <= 0) {
          resolve('');
          return;
        }
        const uriString = documentSaveResult[0];
        if (!uriString) {
          resolve('');
          return;
        }
        const uri = new fileUri.FileUri(uriString);
        resolve(uri.path);
      }).catch((err: BusinessError) => {
        console.error(`===ErrorCode: ${err.code},  Message: ${err.message}`);
        resolve('');
      });
    } catch (error) {
      resolve('');
    }
  })
}