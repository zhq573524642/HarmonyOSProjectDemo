import { List } from "@kit.ArkTS"
import { CommonTitle } from "../component/MyComponent"
import { LengthMetrics } from "@kit.ArkUI"
import { RouterUtil, ToastUtils } from "@ohos/common"

@Entry({ routeName: 'ListTestPage' })
@Component
export struct ListTestPage {
  list: List<number> = new List<number>()
  @State text: string = ''

  static startPage() {
    RouterUtil.pushNamedRoute('ListTestPage')
  }

  aboutToAppear(): void {
    this.list.add(1)
    this.list.add(2)
    this.list.add(3)
    this.getDataContent()
  }

  build() {
    Column({ space: 10 }) {
      CommonTitle({ title: '单向链表-List' })
      Text(this.text)
        .fontColor(Color.Orange)
        .fontSize(17)
      Flex({
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap,
        space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) }
      }) {
        Button('add')
          .onClick(() => {
            let result = this.list.add(this.list.length + 1)
            if (result) {
              ToastUtils.show('add插入成功')
            }
            this.getDataContent()
          })
        Button('insert')
          .onClick(() => {
            this.list.insert(10, 10)
            this.getDataContent()
          })
        Button()
          .onClick(() => {
            let result = this.list.get(0)
            if (result) {
              ToastUtils.show('get:' + result)
            }
          })
      }
    }.width('100%')
    .height('100%')
  }

  getDataContent() {
    let s = ''
    this.list.forEach((value: number, index: number) => {
      s += '、' + value
    })
    this.text = s
  }
}