import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'
import { UIAbility, common } from '@kit.AbilityKit'

@Entry
@Component
struct ArkTSBasePage {
  private context = getContext(this) as common.UIAbilityContext

  build() {

    Column() {
      CommonButton({ text: '数据结构' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/data/DataStructurePage'
          })
        })
      CommonButton({ text: '状态控制' })
        .onClick(() => {
          router.pushUrl({ url: 'pages/state/StateManagerPage' })
        })
      CommonButton({ text: '装饰器' })
        .onClick(() => {
          // this.context.currentHapModuleInfo.
          router.pushUrl({
            url: 'pages/decorator/ArkDecoratorPage'
          })
        })
      CommonButton({text:'并发'})
        .onClick(()=>{
           router.pushUrl({
             url:'pages/concurrency/ConcurrencyPage'
           })
        })
      CommonButton({ text: '消息通信' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ui/arkts/MessageTransmitPage'
          })
        })

      CommonTitle({ title: '应用程序包' })
      CommonButton({ text: 'HAR（静态共享包）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ui/arkts/HarLibPage'
          })
        })
      CommonButton({ text: 'HSP（动态共享包）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ui/arkts/HspLibPage'
          })
        })
      CommonButton({ text: 'UIAbility' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ui/arkts/AbilityTestPage'
          })
        })
      CommonButton({text:'信息传递载体Want'})
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)

  }
}



