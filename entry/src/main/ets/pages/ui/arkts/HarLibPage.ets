import { HarMainPage } from '@ohos/staticLibrary/src/main/ets/components/mainpage/HarMainPage'
import { CommonButton, CommonTitle } from '../../component/MyComponent'

@Entry
@Component
struct HarLibPage {
  build() {
    Column() {
      CommonButton({ text: '跳转Har页面' })
        .onClick(() => {
          HarMainPage.startPage('张较瘦')
        })
      CommonTitle({ title: '引用Har中的资源' })
      Image($r('app.media.har_imge'))
        .width(400)
        .margin({ top: 15 })
        .height(266)
    }.width('100%')
  }
}