import { CommonButton } from '../component/MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct OneMoreMatchPage {
  build() {
    Column() {
      CommonButton({ text: '一多：Tab首页' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/OneMoreForHomeTabPage'
          })
        })
      CommonButton({ text: '一多：Header' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/OneMoreForHeaderPage'
          })
        })
      CommonButton({ text: '一多：媒体查询' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/MediaQueryPage'
          })
        })
      CommonButton({ text: '一多：栅格布局' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/GridRowPage'
          })
        })
    }
    .width('100%')
  }
}