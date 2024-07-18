
@ObservedV2
class PersonBean {
  name: string = ''
  @Trace isSelect: boolean = false
}


@Entry
@Component
struct ListMultipleSelectPage {
  @State dataList: Array<PersonBean> = []
  private scroller: Scroller = new Scroller()
  private images: Resource[] = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3'),]

  aboutToAppear(): void {
    for (let i = 0; i < 20; i++) {
      let bean = new PersonBean()
      bean.name = 'Item-' + i
      bean.isSelect = false
      this.dataList.push(bean)
    }
  }

  build() {
    Column() {
      List({ scroller: this.scroller, space: 10 }) {
        ForEach(this.dataList, (item: PersonBean, index: number) => {
          ListItem() {
            Row() {
              Image(this.images[index%this.images.length]).margin(15).width(60).height(40).borderRadius(12)
              Text(item.name).fontSize(20).fontColor(Color.Black)
            }.alignItems(VerticalAlign.Center)
            .width('100%')
          }
          .margin({ left: 10, right: 10 })
          .backgroundColor(item.isSelect ? Color.Pink : Color.White)
          .borderRadius(12)
          .onClick(() => {
            this.dataList[index].isSelect = !this.dataList[index].isSelect
          })
        }, (item: PersonBean) => JSON.stringify(item))
      }.width('100%')

      .listDirection(Axis.Vertical)
    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}