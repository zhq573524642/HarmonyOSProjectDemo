import { CommonButton } from './MyComponent'
import { ComposeListItem } from '@ohos.arkui.advanced.ComposeListItem'

@Entry
@Component
struct HighRankComponentPage {
  build() {

    Column() {
      CommonButton({ text: 'ComposeListItem' })
        .onClick(() => {

        })
    }
    .width('100%')

  }
}