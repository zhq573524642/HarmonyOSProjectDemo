import { CommonButton } from './MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct HighRankComponentPage {
  build() {

    Column() {
      CommonButton({text:'CounterComponent'})
        .onClick(()=>{
          router.pushUrl({
            url:'pages/component/CounterPage'
          })
        })
      CommonButton({ text: 'SelectTitleBar（下拉菜单标题栏）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/SelectTitleBarPage'
          })
        })
      CommonButton({ text: 'SplitLayout（上下结构布局）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/SplitLayoutPage'
          })
        })
      CommonButton({ text: 'SubHeader（子标题）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/SubHeaderPage'
          })
        })

      CommonButton({ text: 'TreeView（树视图）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/container/TreeViewPage'
          })
        })
    }
    .width('100%')

  }
}