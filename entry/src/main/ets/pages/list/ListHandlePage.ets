import { CommonButton } from '../component/MyComponent'
import { Person } from './Person'

@Preview
@Entry
@Component
struct ListHandlePage {
  @State dataList: Array<string> = []
  private scroller: Scroller = new Scroller()
  private images: Resource[] = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]
  @State isEditMode: boolean = false
  @State selectedData: Array<string> = []

  aboutToAppear(): void {
    for (let i = 0; i < 4; i++) {
      this.dataList.push('Item-' + i)
    }
  }

  build() {

    Column() {
      CommonButton({ text: '增加数据' })
        .onClick(() => {
          this.dataList.push('Item-' + this.dataList.length)
        })
      CommonButton({ text: '删除第一条数据' })
        .onClick(() => {
       let delet=   this.dataList.splice(0,1)
          console.debug('===删除：'+delet)
        })
      CommonButton({ text: '删除最后一条数据' })
        .onClick(() => {
          this.dataList.pop()
        })
      CommonButton({ text: '删除选中的数据' })
        .onClick(() => {
          let temp: Array<string> = []
          temp = this.dataList
          this.selectedData.forEach((value: string) => {
            let index = temp.indexOf(value)
            if (index !== -1) {
              temp.splice(index, 1)
            }
          })
          this.dataList = temp
          this.selectedData = []
          this.isEditMode = false;
        })
      List({ space: 10 }) {
        ForEach(this.dataList, (item: string, index) => {
          ListItem() {
            Row() {
              Image(this.images[index%this.images.length]).margin(15).width(60).height(40).borderRadius(12)
              Text(item).fontSize(20).fontColor(Color.Black)
              Blank().layoutWeight(1)
              if (this.isEditMode) {
                Checkbox()
                  .onChange((isSelected) => {
                    if (isSelected) {
                      console.debug('===触发：' + item)
                      this.selectedData.push(item)
                    } else {
                      let index = this.selectedData.indexOf(item)
                      if (index !== -1) {
                        this.selectedData.splice(index, 1)
                      }
                    }
                    console.debug('===选择的数据：' + JSON.stringify(this.selectedData))
                  })
                  .margin({ right: 20 })
              }
            }.alignItems(VerticalAlign.Center)
            .width('100%')

          }
          .margin({ left: 10, right: 10 })
          .backgroundColor(Color.White)
          .borderRadius(12)
          .gesture(
            GestureGroup(GestureMode.Exclusive,
              LongPressGesture()
                .onAction(() => {
                  if (!this.isEditMode) {
                    this.isEditMode = true
                  }
                }))
          )
        }, (item: string) => JSON.stringify(item))
      }.width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')

  }
}

