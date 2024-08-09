import { CommonButton } from '../component/MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct DataStructurePage {
  build() {
    Column() {
      CommonButton({ text: '数组Array' })
        .onClick(() => {
          router.pushUrl({
             url:'pages/data/ArrayTestPage'
          })
        })
      CommonButton({ text: '集合ArrayList' })
        .onClick(() => {
          router.pushUrl({
            url:'pages/data/ArrayListPage'
          })
        })
    }
  }
}