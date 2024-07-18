import { CommonButton, CommonTitle } from '../component/MyComponent'
import { promptAction, router } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

let uiAbilityLocalStorage = LocalStorage.getShared()

@Entry(uiAbilityLocalStorage)
@Component
struct MainPage {
  private scroller: Scroller = new Scroller()
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext

  aboutToAppear(): void {
    let eventHub = this.context.eventHub //获取eventHub
    eventHub.on('event_1', this.eventHubFunc)
    eventHub.on('event_1', (content: string) => {
      console.debug('===收到EventHub消息1：' + content)
    })
  }

  aboutToDisappear(): void {
    this.context.eventHub.off('event_1', (msg: string) => {
      console.debug('===取消订阅EventHub：event_1')
    })
  }

  eventHubFunc(arg1: Context, arg2: Context) {
    promptAction.showToast({ message: `收到消息：数据1：${arg1}，数据2：${arg2}` })
    console.debug('===收到EventHub消息2：' + arg1 + '--' + arg2)
  }

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
        CommonButton({ text: '网络请求axios' })
          .onClick(() => {
            router.pushUrl({
              url:'pages/network/NetworkTestPage'
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
    }

  }
}