import { HspResManager } from '@ohos/sharedLibrary'
import { HspMainPage } from '@ohos/sharedLibrary/src/main/ets/pages/HspMainPage'
import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct HspLibPage {
  pathStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pathStack) {
      Column() {
        CommonTitle({ title: 'Route跳转HSP页面' })
        CommonButton({ text: '跳转HSP页面（Router）' })
          .onClick(() => {
            HspMainPage.startPage('111')
          })
        CommonButton({ text: '跳转HSP页面（全路径）' })
          .onClick(() => {
            router.pushUrl({
              url: '@bundle:com.zhq.harmonyosdemo/sharedLibrary/ets/pages/HspMainPage',
              params: {
                param_name: '222'
              }
            })
          })

        CommonTitle({ title: '使用Navigation跳转HSP页面' })

        CommonButton({text:'跳转HSP页面'})
          .onClick(()=>{
             this.pathStack.pushPathByName("HspMainPage",new Object({
               "param":"333"
             }))
          })

        CommonTitle({ title: '加载HSP中的资源：最好是通过资源管理类' })

        Blank().width(100)
          .height(100)
          .backgroundColor(HspResManager.getTestColor()).margin(10)
        Image(HspResManager.getTestImg()).width(400)
          .height(266).margin(10)
      }.width('100%')
    }.title("引用HSP操作")
    .titleMode(NavigationTitleMode.Mini)
    .width('100%')
    .height('100%')
    .mode(NavigationMode.Stack)

  }
}