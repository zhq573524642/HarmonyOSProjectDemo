import { CommonButton, CommonTitle } from '../component/MyComponent'
import { promptAction, router } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

let uiAbilityLocalStorage = LocalStorage.getShared()

@Entry(uiAbilityLocalStorage)
@Component
struct MainPage {
  private scroller: Scroller = new Scroller()
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: 'ArkTS基础' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkts/ArkTSBasePage'
            })
          })
        CommonButton({ text: 'ArkUI组件' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkui/ArkUIPage',
            })
          })
        CommonButton({ text: '网络请求axios' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/network/NetworkTestPage'
            })
          })
        CommonButton({ text: '动画' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/animate/AnimationPage'
            })
          })
        CommonButton({ text: '权限申请' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/permission/PermissionsPage'
            })
          })
        CommonButton({text:'ArkWeb'})
          .onClick(()=>{
             router.pushUrl({
               url:'pages/web/WebPage',
               params:{
                 web_url:'https://beta-app.yiboshi.com/appAgreement/ybs'
               }
             })
          })
        CommonTitle({ title: 'Camera Kit' })
        CommonButton({ text: '相机开发' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/camera/CameraKitPage'
            })
          })
        CommonTitle({ title: 'Audio Kit' })
        CommonTitle({ title: 'Core Vision Kit（基础视觉服务）' })
        CommonButton({ text: '文字识别' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ai/TextRecognitionPage'
            })
          })
        CommonButton({ text: '人脸识别' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ai/FaceDetectorPage'
            })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

    }.width('100%')
  }
}