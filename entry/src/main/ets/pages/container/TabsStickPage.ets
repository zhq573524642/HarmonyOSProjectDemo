import { RouterUtil } from "@ohos/common";

@Entry({ routeName: 'TabsStickPage' })
@Component
export struct TabsStickPage {
  static start() {
    RouterUtil.pushNamedRoute('TabsStickPage')
  }

  @State list: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']
  @State curIndex: number = 0

  aboutToAppear(): void {
  }

  build() {
    Scroll() {
      Column() {

        Text('Banner').width('100%')
          .height(200)
          .backgroundColor(Color.Yellow)
          .textAlign(TextAlign.Center)

        Stack({ alignContent: Alignment.TopEnd }) {
          Column() {
            Tabs({
              barPosition: BarPosition.Start,
              index: this.curIndex
            }) {
              TabContent() {
                  TabContentList({list:this.list})
              }.tabBar('数据1')

              TabContent() {
                TabContentList({list:this.list})
              }.tabBar('数据2')

              TabContent() {
                TabContentList({list:this.list})
              }.tabBar('数据3')
            }
          }

        }
      }.width('100%')
      .layoutWeight(1)
    }.width('100%')
    .height('100%')
    .backgroundColor('#EEEEEE')
  }
}

@Component
export struct TabContentList {
  @State list: string[] = []

  build() {
    Column(){
      List({ space: 10 }) {
        ForEach(this.list, (item: string, index: number) => {
          ListItem() {
            Text(item).width('100%')
              .height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Gray)
          }
        }, (item: string) => JSON.stringify(item))
      }
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })
    }

  }
}