import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct ListVerticalPage {
  @State dataList: Array<string> = []
  private scrollerList: Scroller = new Scroller()
  private images: Resource[] = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]
  @State scrollLocation: string = ''
  @State scrollInfo: string = ''
  handleScrollCallback: OnScrollCallback = (scrollOffset: number, state: ScrollState) => {
       this.scrollInfo='滑动方向='+(scrollOffset>0?'上滑':'下滑')+'--scrollState:'+state.toString()
  }

  aboutToAppear(): void {
    for (let i = 0; i < 20; i++) {
      this.dataList.push('Item-' + i)
    }
  }

  build() {
    Column() {
      Column() {
        Text(`列表滑动位置：${this.scrollLocation}`).fontSize(14).margin(8)
        Text(`滑动状态：${this.scrollInfo}`).fontSize(14).margin(8)
      }.backgroundColor(Color.White)
      .width('100%')

      List({ scroller: this.scrollerList, space: 10 }) {
        ForEach(this.dataList, (item: string, index: number) => {
          ListItem() {
            Column() {
              Image(this.images[index%this.images.length])
                .borderRadius({
                  topLeft: 12,
                  topRight: 12,
                  bottomLeft: 0,
                  bottomRight: 0
                })
                .objectFit(ImageFit.Cover)
                .width('100%')
                .height(200)
              Text(`${item}`).fontSize(15).fontColor(Color.Black).margin(10)
              Text(`subTitle-${index}`).fontSize(13).fontColor(Color.Gray).margin({ left: 10, bottom: 10 })
            }.width('100%')
            .backgroundColor(Color.White)
            .borderRadius(12)
            .alignItems(HorizontalAlign.Start)
          }
          .margin({ left: 10, right: 10 })
        }, (item: string) => item)
      }
      .width('100%')
      .margin({ top: 10, bottom: 10 })
      .nestedScroll({ scrollForward: NestedScrollMode.SELF_FIRST, scrollBackward: NestedScrollMode.SELF_FIRST })
      .listDirection(Axis.Vertical)
      .onReachStart(() => {
        this.scrollLocation = '到达列表开始位置'
      })
      .onReachEnd(() => {
        this.scrollLocation = '到达列表结束位置'
      })
      .onScrollStart(() => {
        this.scrollInfo = '开始滑动'
      })
      .onScrollStop(() => {
        this.scrollInfo = '结束滑动'
      })
      .onDidScroll(this.handleScrollCallback)
      Image($r('app.media.img2')).width('100%')
        .objectFit(ImageFit.Cover)
    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}