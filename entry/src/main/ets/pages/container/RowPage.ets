import { CommonButton, CommonButton1 } from '../component/MyComponent'
import { Square } from '../component/MyComponent'

@Entry
@Component
struct RowPage {
  @State btn1: string = '在交叉抽上:VerticalAlign.Top'
  @State btn2: string = '在主抽上:FlexAlign.Start'
  private alignItems: Array<VerticalAlign> = [VerticalAlign.Top, VerticalAlign.Center, VerticalAlign.Bottom]
  private justifyContent: Array<FlexAlign> = [FlexAlign.Start, FlexAlign.Center, FlexAlign.End, FlexAlign.SpaceBetween, FlexAlign.SpaceAround, FlexAlign.SpaceEvenly]
  @State alignItemsTag: number = 0
  @State justifyContentTag: number = 0
  @State isShowRowSplit: boolean = false

  build() {
    Column() {
      CommonButton({ text: '切换显示Row/RowSplit(真机中)' })
        .onClick(() => {
          this.isShowRowSplit = !this.isShowRowSplit
        })
      Column() {
        CommonButton1({ text: $btn1 })
          .onClick(() => {
            this.alignItemsTag++
            if (this.alignItemsTag >= this.alignItems.length) {
              this.alignItemsTag = 0
            }
            switch (this.alignItemsTag) {
              case 0:
                this.btn1 = '在交叉抽上:VerticalAlign.Top'
                break
              case 1:
                this.btn1 = '在交叉抽上:VerticalAlign.Center'
                break
              case 2:
                this.btn1 = '在交叉抽上:VerticalAlign.Bottom'
                break
            }

          })
        CommonButton1({ text: $btn2 })
          .onClick(() => {
            this.justifyContentTag++
            if (this.justifyContentTag >= this.justifyContent.length) {
              this.justifyContentTag = 0
            }
            switch (this.justifyContentTag){
              case 0:
                this.btn2 = '在主抽上:FlexAlign.Start'
              break
              case 1:
                this.btn2 = '在主抽上:FlexAlign.Center'
                break
              case 2:
                this.btn2 = '在主抽上:FlexAlign.End'
                break
              case 3:
                this.btn2 = '在主抽上:FlexAlign.SpaceBetween'
                break
              case 4:
                this.btn2 = '在主抽上:FlexAlign.SpaceAround'
                break
              case 5:
                this.btn2 = '在主抽上:FlexAlign.SpaceEvenly'
                break
            }

          })

        Row() {
          Square({ text: 'Item-1', color: Color.Red })
          Square({ text: 'Item-2', color: Color.Green })
          Square({ text: 'Item-3', color: Color.Yellow })

        }
        .alignItems(this.alignItems[this.alignItemsTag%this.alignItems.length])
        .justifyContent(this.justifyContent[this.justifyContentTag%this.justifyContent.length])
        .width('100%')
        .layoutWeight(1)
      }.width('100%')
      .layoutWeight(1)
      .visibility(this.isShowRowSplit ? Visibility.None : Visibility.Visible)

      Column() {
        RowSplit() {
          Text('Item_1').width(50).height(50).backgroundColor(Color.Orange).textAlign(TextAlign.Center)
          Text('Item_2').width(50).height(50).backgroundColor(Color.Red).textAlign(TextAlign.Center)
          Text('Item_3').width(50).height(50).backgroundColor(Color.Pink).textAlign(TextAlign.Center)
          Text('Item_4').width(50).height(50).backgroundColor(Color.Green).textAlign(TextAlign.Center)
          Text('Item_5').width(50).height(50).backgroundColor(Color.Blue).textAlign(TextAlign.Center)

        }.resizeable(true)
        .borderWidth(1)
        .width('100%')
        .height('100%')
      }.width('100%')
      .layoutWeight(1)
      .visibility(this.isShowRowSplit ? Visibility.Visible : Visibility.None)

    }
    .height('100%')
    .width('100%')
  }
}

