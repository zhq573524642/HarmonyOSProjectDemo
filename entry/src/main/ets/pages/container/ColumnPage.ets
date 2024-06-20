import { CommonButton, CommonButton1 } from '../component/MyComponent'
import { Square } from '../component/MyComponent'

@Entry
@Component
struct ColumnPage {
  @State btn1: string = '在交叉抽上:HorizontalAlign.Start'
  @State btn2: string = '在主抽上:FlexAlign.Start'
  private alignItems: Array<HorizontalAlign> = [HorizontalAlign.Start, HorizontalAlign.Center, HorizontalAlign.End]
  private justifyContent: Array<FlexAlign> = [FlexAlign.Start, FlexAlign.Center, FlexAlign.End,
    FlexAlign.SpaceBetween, FlexAlign.SpaceAround, FlexAlign.SpaceEvenly]
  @State private alignItemsTag: number = 0
  @State private justifyContentTag: number = 0
  @State isShowColumnSplit: boolean = false

  build() {
    Column() {
      CommonButton({ text: '切换显示Column/ColumnSplit(真机中)' })
        .onClick(() => {
          this.isShowColumnSplit = !this.isShowColumnSplit
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
                this.btn1 = '在交叉抽上:HorizontalAlign.Start'
                break
              case 1:
                this.btn1 = '在交叉抽上:HorizontalAlign.Center'
                break
              case 2:
                this.btn1 = '在交叉抽上:HorizontalAlign.End'
                break
            }

          })
        CommonButton1({ text: $btn2 })
          .onClick(() => {
            this.justifyContentTag++
            if (this.justifyContentTag >= this.justifyContent.length) {
              this.justifyContentTag = 0
            }
            switch (this.justifyContentTag) {
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


        Column() {
          Square({ text: '1', color: Color.Red, w: 50, h: 50 })
          Square({ text: '2', color: Color.Green, w: 50, h: 50 })
          Square({ text: '3', color: Color.Yellow, w: 50, h: 50 })

        }
        .backgroundColor(Color.Gray)
        .alignItems(this.alignItems[this.alignItemsTag%this.alignItems.length])
        .justifyContent(this.justifyContent[this.justifyContentTag%this.justifyContent.length])
        .width('100%')
        .layoutWeight(1)
      }.width('100%')
      .margin(10)
      .layoutWeight(1)
      .visibility(this.isShowColumnSplit ? Visibility.None : Visibility.Visible)

      Column() {
        ColumnSplit() {
          Text('Item_1').width('100%').height(40).backgroundColor(Color.Orange).textAlign(TextAlign.Center)
          Text('Item_2').width('100%').height(40).backgroundColor(Color.Blue).textAlign(TextAlign.Center)
          Text('Item_3').width('100%').height(40).backgroundColor(Color.Gray).textAlign(TextAlign.Center)
          Text('Item_4').width('100%').height(40).backgroundColor(Color.Green).textAlign(TextAlign.Center)
          Text('Item_5').width('100%').height(40).backgroundColor(Color.Red).textAlign(TextAlign.Center)
          Text('Item_6').width('100%').height(40).backgroundColor(Color.Pink).textAlign(TextAlign.Center)
        }
        .resizeable(true)
        .borderWidth(1)
        .margin(10)
        .width('100%')
        .height('100%')
      }.width('100%')
      .visibility(this.isShowColumnSplit ? Visibility.Visible : Visibility.None)
      .layoutWeight(1)

    }
    .height('100%')
    .width('100%')
  }
}

