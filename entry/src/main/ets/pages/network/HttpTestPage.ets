import { CommonButton } from '../component/MyComponent'
import { http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { httpRequestGet } from './HttpUtils'
import { BannerBean, BannerData } from './BannerBean'
import { ToastUtils } from '@ohos/common'
import httpHeader from './DefaultHttpHeader'

const TAG_HEADER_RECEIVE: string = 'headersReceive'

@Entry
@Component
struct HttpTestPage {
  @State dataList: Array<BannerData> = []
  swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      CommonButton({ text: 'Http请求' })
        .onClick(() => {
          this.handleHttpGetRequest()
        })

      Swiper(this.swiperController) {
        ForEach(this.dataList, (item: BannerData) => {
          Column() {
            Image(item.imagePath)
              .width('100%')
              .height(200)
              .objectFit(ImageFit.Contain)
            Text(item.title).fontColor(Color.Black).fontSize(16)
              .margin({ top: 10, left: 10 })
            Text(item.desc).fontColor(Color.Gray).fontSize(14)
              .margin({ top: 5, left: 10 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

        }, (item: BannerData) => item.id + '')
      }
      .autoPlay(true)
      .indicator(true)
      .itemSpace(20)
      .width('100%')

    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }

  handleHttpGetRequest() {
    httpHeader.contentTypeValue = 'application/json'
    httpHeader.tokenValue = '111111111111111'
    httpRequestGet<BannerBean>('/banner/json', '', httpHeader, http.HttpDataType.OBJECT)
      .then((data: BannerBean) => {
        if (data) {
          this.dataList = data.data
        }
      })
      .catch((error: string) => {
        ToastUtils.show(error)
      })
  }
}