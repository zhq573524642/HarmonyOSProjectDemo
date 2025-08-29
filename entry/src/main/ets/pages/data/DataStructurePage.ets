import { CommonButton, CommonTitle } from '../component/MyComponent'
import { router } from '@kit.ArkUI'
import { RouterUtil } from '@ohos/common'
import { ArrayListPage } from './ArrayListPage'
import { ListTestPage } from './ListTestPage'

@Entry({ routeName: 'DataStructurePage' })
@Component
export struct DataStructurePage {
  static startPage() {
    RouterUtil.pushNamedRoute('DataStructurePage')
  }

  build() {
    Column() {
      CommonTitle({ title: '线性容器' })
      CommonButton({ text: 'Array数组' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/data/ArrayTestPage'
          })
        })
      CommonButton({ text: 'ArrayList动态数组' })
        .onClick(() => {
          ArrayListPage.startPage()
        })
      CommonButton({ text: 'List单向链表' })
        .onClick(() => {
          ListTestPage.startPage()
        })
      CommonButton({ text: 'LinkedList双向链表' })
        .onClick(() => {

        })
      CommonButton({ text: 'Deque双向队列' })
        .onClick(() => {

        })
      CommonButton({ text: 'Queue单向队列' })
        .onClick(() => {

        })
      CommonButton({ text: 'Stack栈' })
        .onClick(() => {

        })

      CommonTitle({ title: '非线性容器' })
      CommonButton({ text: 'HashMap' })
        .onClick(() => {

        })
      CommonButton({ text: 'HashSet' })
        .onClick(() => {

        })
      CommonButton({ text: 'TreeMap' })
        .onClick(() => {

        })
      CommonButton({ text: 'TreeSet' })
        .onClick(() => {

        })
      CommonButton({ text: 'LightWeightMap' })
        .onClick(() => {

        })
      CommonButton({ text: 'LightWeightSet' })
        .onClick(() => {

        })
      CommonButton({ text: 'PlainArray' })
        .onClick(() => {

        })
    }
  }
}