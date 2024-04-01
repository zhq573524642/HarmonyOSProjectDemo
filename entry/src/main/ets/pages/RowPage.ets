import { CommonButton } from './component/MyComponent'
import { Square } from './component/MyComponent'

@Entry
@Component
struct RowPage {
  @State btn1: string = '子元素在交叉抽上对齐方式'
  @State btn2: string = '子元素在主抽上对齐方式'
  @State alignItems: VerticalAlign = VerticalAlign.Top
  @State justifyContent: FlexAlign = FlexAlign.SpaceBetween

  build() {
    Column() {
      CommonButton({ text: this.btn1 })
        .onClick(() => {
          if (this.alignItems == VerticalAlign.Top) {
            this.alignItems = VerticalAlign.Center
          } else if (this.alignItems == VerticalAlign.Center) {
            this.alignItems = VerticalAlign.Bottom
          } else if (this.alignItems == VerticalAlign.Bottom) {
            this.alignItems = VerticalAlign.Top
          }
        })
      CommonButton({ text: this.btn2 })
        .onClick(() => {
          if (this.justifyContent == FlexAlign.Start) {
            this.justifyContent = FlexAlign.Center
          } else if (this.justifyContent == FlexAlign.Center) {
            this.justifyContent = FlexAlign.End
          } else if (this.justifyContent == FlexAlign.End) {
            this.justifyContent = FlexAlign.SpaceBetween
          } else if (this.justifyContent == FlexAlign.SpaceBetween) {
            this.justifyContent = FlexAlign.SpaceAround
          } else if (this.justifyContent == FlexAlign.SpaceAround) {
            this.justifyContent = FlexAlign.SpaceEvenly
          } else if (this.justifyContent == FlexAlign.SpaceEvenly) {
            this.justifyContent = FlexAlign.Start
          }

        })

      Row() {
        Square({ text: 'Item-1', color: Color.Red })
        Square({ text: 'Item-2', color: Color.Green })
        Square({ text: 'Item-3', color: Color.Yellow })

      }
      .alignItems(this.alignItems)
      .justifyContent(this.justifyContent)
      .backgroundColor(Color.Blue)
      .width('100%')
      .height('80%')
    }
    .height('100%')
    .width('100%')
  }
}

