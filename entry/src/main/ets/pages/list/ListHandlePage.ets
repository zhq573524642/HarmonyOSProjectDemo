import { CommonButton } from '../component/MyComponent'
import { Person } from './Person'

@Preview
@Entry
@Component
struct ListHandlePage {
  private addData: string[] = [
    '侯九',
    '麻少',
    '龙少',
    '涛哥',
    '兵哥',
  ]
  @State private listData: Person[] = [
    new Person('张三', '17610676602'),
    new Person('赵四', '18927366363'),
    new Person('王五', '15662537778'),
    new Person('李六', '13987387728'),
    new Person('陈七', '13182673827'),
    new Person('刘八', '15762526636'),
  ]
  @State isEditMode: boolean = false
  @State selectedData: Person[] = []

  @Builder itemDeleteEnd(index: number) {
    Text('删除')
      .fontColor(Color.White)
      .fontSize(16)
      .width(60)
      .height(45)
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Red)
      .onClick(() => {
        this.listData.splice(index, 1)
      })
  }

  build() {

    Column() {
      CommonButton({ text: '增加数据' })
        .onClick(() => {
          TextPickerDialog.show({
            range: this.addData,
            onAccept: (value: TextPickerResult) => {
              this.listData.push(new Person(this.addData[value.index], '18792728888'))
            }
          })
        })
      CommonButton({ text: '删除选中的数据' })
        .onClick(() => {
          let leftData = this.listData.filter((item) => {
            return this.selectedData.find((selectedItem) => selectedItem !== item);
          })

          this.listData = leftData;
          this.isEditMode = false;
        })
      List({ space: 20 }) {
        ForEach(this.listData, (item: Person, index) => {
          ListItem() {
            Row() {
              Text(item.name)
                .fontSize(20)
                .fontColor(Color.Red)
                .margin({ left: 15 })
              Text(item.phone)
                .fontSize(16)
                .fontColor(Color.Green)
                .margin({ left: 10 })
              if (this.isEditMode) {
                Checkbox()
                  .onChange((isSelected) => {
                    if (isSelected) {
                      this.selectedData.push(item)
                    } else {
                      let index = this.selectedData.indexOf(item)
                      if (index !== -1) {
                        this.selectedData.splice(index, 1)
                      }
                    }
                  })
                  .margin({ left: 20 })
              }
            }
            .width('100%')
            .height(45)
            .backgroundColor(this.isEditMode ? Color.Grey : Color.White)
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Start)

          }
          .gesture(
            GestureGroup(GestureMode.Exclusive,
              LongPressGesture()
                .onAction(() => {
                  if (!this.isEditMode) {
                    this.isEditMode = true
                    this.selectedData.push(item)
                  }
                }))
          )
          .swipeAction({ end: this.itemDeleteEnd(index) })
        }, item => item.key)
      }.width('100%')
      .divider({ strokeWidth: 2, color: Color.Brown, startMargin: 10, endMargin: 10 })
    }
    .height('100%')
    .width('100%')

  }
}

