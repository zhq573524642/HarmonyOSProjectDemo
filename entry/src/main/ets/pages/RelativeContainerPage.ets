import { Square } from './component/MyComponent'

@Entry
@Component
struct RelativeContainerPage {
  @State message: string = 'Hello World'

  build() {
    //未设置id的子元素不会在相对布局中显示
    RelativeContainer() {
      Square({ text: 'item1', color: Color.Red, w: 50, h: 50 })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .id('square1')
      Square({ text: 'item2', color: Color.Yellow, w: 50, h: 50 })
        .alignRules({
          top: { anchor: 'square1', align: VerticalAlign.Center },
          left: { anchor: 'square1', align: HorizontalAlign.End }
        })
        .id('square2')
    }.width('100%')
    .height('100%')
    .backgroundColor('#e8e8e8')
  }
}