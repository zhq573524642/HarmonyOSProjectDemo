import { HspResManager } from '@ohos/sharedLibrary'
import { HspMainPage } from '@ohos/sharedLibrary/src/main/ets/pages/HspMainPage'
import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct HspLibPage {
  build() {
    Column() {

      CommonButton({ text: '跳转HSP（动态共享包HspMainPage页面组件）1' })
        .onClick(() => {
          HspMainPage.startPage('张教授')
        })
      CommonButton({ text: '跳转HSP（动态共享包HspMainPage页面组件）2' })
        .onClick(() => {
          router.pushUrl({
            url:'@bundle:com.example.myapplication/sharedLibrary/ets/pages/HspMainPage'
          })
        })
      CommonTitle({ title: '加载HSP中的资源' })

      Blank().width(100)
        .height(100)
        .backgroundColor(HspResManager.getTestColor()).margin(10)
      Image(HspResManager.getTestImg()).width(400)
        .height(266).margin(10)
    }.width('100%')
  }
}