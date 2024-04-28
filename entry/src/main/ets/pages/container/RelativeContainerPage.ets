import { Square } from '../component/MyComponent'

@Entry
@Component
struct RelativeContainerPage {

  build() {
    //未设置id的子元素不会在相对布局中显示
    RelativeContainer() {
      Square({ text: 'item1', color: Color.Red, w: 50, h: 50 })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('square1')
      Square({ text: 'item2', color: Color.Yellow, w: 50, h: 50 })
        .alignRules({
          top: { anchor: 'square1', align: VerticalAlign.Bottom },
          left: { anchor: 'square1', align: HorizontalAlign.End }
        })
        .id('square2')
      Square({ text: 'item3', color: Color.Green, w: 50, h: 50 })
        .alignRules({
          top: { anchor: 'square2', align: VerticalAlign.Center },
          left: { anchor: 'square2', align: HorizontalAlign.End }
        })
        .id('square3')
      Square({ text: 'item4', color: Color.Pink, w: 50, h: 50 })
        .alignRules({
          top: { anchor: 'square3', align: VerticalAlign.Bottom },
          left: { anchor: 'square1', align: HorizontalAlign.End }
        })
        .id('square4')
    }.width('100%')
    .height('100%')
    .backgroundColor('#e8e8e8')
  }
}