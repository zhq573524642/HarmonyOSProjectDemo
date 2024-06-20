import { CommonButton, CommonTitle } from '../component/MyComponent'
import { router } from '@kit.ArkUI'

let uiAbilityLocalStorage = LocalStorage.getShared()

@Entry(uiAbilityLocalStorage)
@Component
struct MainPage {
  private scroller: Scroller = new Scroller()

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
              url: 'pages/ui/arkui/ArkUIPage'
            })
          })
        CommonButton({ text: '动画' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/animate/AnimationPage'
            })
          })
        CommonTitle({title:'Core Vision Kit（基础视觉服务）'})
        CommonButton({text:'文字识别'})
          .onClick(()=>{
             router.pushUrl({
               url:'pages/ai/TextRecognitionPage'
             })
          })
        CommonButton({text:'人脸识别'})
          .onClick(()=>{
            router.pushUrl({
              url:'pages/ai/FaceDetectorPage'
            })
          })
      }
      .width('100%')
    }

  }
}