import { it } from '@ohos/hypium/src/main/interface'

@Entry
@Component
struct ListItemDragPage {
  @State dataList: Array<string> = []
  private scroller: Scroller = new Scroller()
  private images: Resource[] = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3'),]

  aboutToAppear(): void {
    for (let i = 0; i < 20; i++) {
      this.dataList.push('Item-' + i)
    }
  }

  build() {
    Column() {
      List({ scroller: this.scroller, space: 10 }) {
        ForEach(this.dataList, (item: string, index: number) => {
          ListItem() {
            Row() {
              Image(this.images[index%this.images.length]).margin(15).width(60).height(40).borderRadius(12)
              Text(item).fontSize(20).fontColor(Color.Black)
            }.alignItems(VerticalAlign.Center)
            .width('100%')

          }
          .margin({ left: 10, right: 10 })
          .backgroundColor(Color.White)
          .borderRadius(12)
        }, (item: string) => item)
          // .onMove((from:number, to:number) => {
          //   let tmp = this.dataList.splice(from, 1);
          //   this.dataList.splice(to, 0, tmp[0])
          // })
      }

      .width('100%')
      .chainAnimation(true) //列表条目联动的动画
      .listDirection(Axis.Vertical)
      .draggable(true)
      // .onItemDragStart((event: ItemDragInfo, itemIndex: number) => {
      //   console.debug('===onItemDragStart: x=' + event.x + '--y=' + event.y+'--itemIndex:'+itemIndex)
      //
      // })
      .onItemMove((from: number, to: number) => {
        console.debug('===onItemMove')
        return false
      })
      // .onItemDragEnter((event: ItemDragInfo) => {
      //   console.debug('===onItemDragEnter: x=' + event.x + '--y=' + event.y)
      // })
      // .onItemDragMove((event: ItemDragInfo, itemIndex: number, insertIndex: number) => {
      //   console.debug('===onItemDragMove: x=' + event.x + '--y=' + event.y
      //     + '\nitemIndex:' + itemIndex + '--insertIndex:' + insertIndex)
      // })
      // .onItemDragLeave((event: ItemDragInfo, itemIndex: number) => {
      //   console.debug('===onItemDragEnter: x=' + event.x + '--y=' + event.y + '--itemIndex:' + itemIndex)
      // })
      // .onItemDrop((event: ItemDragInfo, itemIndex: number, insertIndex: number, isSuccess: boolean) => {
      //   console.debug('===onItemDrop: x=' + event.x + '--y=' + event.y + '\nitemIndex:' + itemIndex + '--insertIndex:' +
      //     insertIndex + '--isSuccess:' + isSuccess)
      // })
    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}