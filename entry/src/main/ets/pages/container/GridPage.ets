import thermal from '@ohos.thermal'

@Observed
class GridData {
  public name: string = ''
  public isSelect: boolean = false
}

@Entry
@Component
struct GridPage {
  private scroller: Scroller = new Scroller()
  private scroller1: Scroller = new Scroller()
  private gridData: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31']
  @State dataList: Array<GridData> = []

  aboutToAppear(): void {

    for (let i = 0; i < 10; i++) {
      let data: GridData = new GridData()
      data.name = 'item-' + i
      data.isSelect = false
      this.dataList.push(data)
    }
  }

  build() {
    Column() {
      Row() {
        Button('上一页').onClick(() => {
          this.scroller.scrollPage({ next: false })
        })
        Button('下一页').onClick(() => {
          this.scroller.scrollPage({ next: true })
        })
      }.justifyContent(FlexAlign.SpaceEvenly).width('100%')

      Grid(this.scroller) {
        ForEach(this.gridData, (item: number, index) => {
          GridItem() {
            Text(item + '')
              .fontColor(Color.Black)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
          }
          .width(100)
          .height(100)
          .backgroundColor(Color.Gray)

        }, (item: string) => item)
      }
      // .maxCount(3)
      // .layoutDirection(GridDirection.Row)
      // .columnsTemplate('1fr 6fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .columnsGap(10)
      .margin(10)
      .height(250)
      .rowsGap(10)

      Grid(this.scroller1) {
         ForEach(this.dataList,(item:GridData,index:number)=>{
            GridItem(){
               this.goodsItemView(item,index)
            }.width('100%')
            .height(50)
         },(item:GridData)=>JSON.stringify(item))
      }
      .width('100%')
      .columnsTemplate('1fr 1fr')
      .columnsGap(12)
      .layoutDirection(GridDirection.Column)
      .rowsGap(12)
      .padding({ left: 25, right: 25 })
      .height(125)
    }.width('100%')
    .height('100%')
  }

  @Builder
  goodsItemView(item: GridData, index: number) {
    Column() {
      Text(`${item.name}`).fontSize(14).fontColor(item.isSelect ? Color.White : Color.Black)
      Text( '222')
        .fontColor(item.isSelect ? Color.White : Color.Black)
        .fontSize(10)
        .margin({ top: 6 })
    }
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 10, bottom: 10 })
    .width('100%')
    .borderRadius(5)
    .backgroundColor(item.isSelect ? '#4f89ff' : '#f1f1f1')
    .onClick(() => {
      for (let i = 0; i < this.dataList.length; i++) {
        console.debug('==='+i+'=='+index)
        this.dataList[i].isSelect = i == index
      }

    })

  }
}