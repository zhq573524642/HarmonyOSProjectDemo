import { CommonButton } from '../component/MyComponent'

@Entry
@Component
struct StackPage {
  @State message: string = 'Hello World'
  @State alignContentState: Alignment = Alignment.TopStart

  build() {
    Column() {
      CommonButton({ text: '切换alignContent' })
        .onClick(() => {
          if (this.alignContentState == Alignment.TopStart) {
            this.alignContentState = Alignment.Top
          } else if (this.alignContentState == Alignment.Top) {
            this.alignContentState = Alignment.TopEnd
          } else if (this.alignContentState == Alignment.TopEnd) {
            this.alignContentState = Alignment.Start
          } else if (this.alignContentState == Alignment.Start) {
            this.alignContentState = Alignment.Center
          } else if (this.alignContentState == Alignment.Center) {
            this.alignContentState = Alignment.End
          } else if (this.alignContentState == Alignment.End) {
            this.alignContentState = Alignment.BottomStart
          } else if (this.alignContentState == Alignment.BottomStart) {
            this.alignContentState = Alignment.Bottom
          } else if (this.alignContentState == Alignment.Bottom) {
            this.alignContentState = Alignment.BottomEnd
          } else if (this.alignContentState == Alignment.BottomEnd) {
            this.alignContentState = Alignment.TopStart
          }
        })
      Stack({}) {
        Column() {
          Text('item-1')
            .fontColor(Color.Black)
            .fontSize(20)
        }.width('60%').height('60%').backgroundColor(Color.Red).justifyContent(FlexAlign.Center)

        Column() {
          Text('item-2')
            .fontColor(Color.Black)
            .fontSize(20)
        }.width('40%').height('40%').backgroundColor(Color.Yellow).justifyContent(FlexAlign.Center)

        Column() {
          Text('item-3')
            .fontColor(Color.Black)
            .fontSize(20)

        }.width('20%').height('20%').backgroundColor(Color.Blue).justifyContent(FlexAlign.Center)

      }.height('80%')
      .width('100%')
      .alignContent(this.alignContentState)
      .backgroundColor('#e8e8e8')
    }.width('100%')
    .height('100%')
  }
}