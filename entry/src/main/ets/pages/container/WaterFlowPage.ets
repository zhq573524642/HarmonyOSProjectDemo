import { WaterFlowDataSource } from './WaterFlowDataSorce'

@Entry
@Component
struct WaterFlowPage {
  private scroller: Scroller = new Scroller()
  private datasource: WaterFlowDataSource = new WaterFlowDataSource()
  @State minSize: number = 50
  @State maxSize: number = 100
  @State fontSize: number = 24
  @State colors: number[] = [0xFFC0CB, 0xDA70D6, 0x6B8E23, 0x6A5ACD, 0x00FFFF, 0x00FF7F]
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []
  private images: Array<ResourceStr> = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]

  // 计算flow item宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 保存flow item宽/高
  getItemSizeArray() {
    for (let i = 0; i < 100; i++) {
      this.itemWidthArray.push(this.getSize())
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.getItemSizeArray()
  }

  @Builder
  itemFoot() {
    Column() {
      Text(`Footer`)
        .fontSize(10)
        .backgroundColor(Color.Red)
        .width(50)
        .height(50)
        .align(Alignment.Center)
        .margin({ top: 2 })
    }
  }

  build() {
    Column() {
      WaterFlow({ footer: this.itemFoot.bind(this), scroller: this.scroller }) {
        LazyForEach(this.datasource, (item: number, index) => {
          FlowItem() {
            Column() {
              Image(this.images[item%3]).objectFit(ImageFit.Fill)
              Text(item + '')
                .fontSize('12vp')
                .height(20)
                .textAlign(TextAlign.Center)
                .fontColor(Color.Black)
                .backgroundColor(this.colors[item%this.colors.length])

            }
            .backgroundColor(this.colors[item%this.colors.length])
          }.width(this.itemWidthArray[item])
          .height(this.itemHeightArray[item])
          .backgroundColor(this.colors[item%this.colors.length])
        })
      }
      .layoutDirection(FlexDirection.Column)
      .columnsTemplate('1fr 1fr 1fr 1fr') //列的数量
      .columnsGap(10) //列与列的间距
      .rowsGap(5) //行与行的间距
      .itemConstraintSize({
        //宽高范围约束
        minWidth: 0,
        maxWidth: '100%',
        minHeight: 0,
        maxHeight: '100%'
      })

      .width('100%')
    }.width('100%')
    .height('100%')
  }
}