import { HarMainPage } from '@ohos/staticLibrary/src/main/ets/components/mainpage/HarMainPage'
import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct HarLibPage {
  navPathStack:NavPathStack=new NavPathStack()
  build() {
    Navigation(){
      Column() {
        CommonTitle({title:'跳转Har页面'})
        CommonButton({ text: '跳转Har页面（Router）' })
          .onClick(() => {
            HarMainPage.startPage('111')
          })

        CommonButton({text:'跳转Har页面（navigation）'})
          .onClick(()=>{
             this.navPathStack.pushPathByName("HarMainPage",new Object({
               "param":"333"
             }))
          })
        CommonTitle({ title: '引用Har中的资源：可以直接使用$r进行引用' })
        Image($r('app.media.har_imge'))
          .width(400)
          .margin({ top: 15 })
          .height(266)
      }.width('100%')
    }.width('100%')
    .height('100%')
    .titleMode(NavigationTitleMode.Mini)
    .title('引用Har操作')

  }
}