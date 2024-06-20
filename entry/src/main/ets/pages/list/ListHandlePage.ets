import { CommonButton } from '../component/MyComponent'
import { Person } from './Person'

@Preview
@Entry
@Component
struct ListHandlePage {
  private addData: Array<string> = [
    '侯九',
    '麻少',
    '龙少',
    '涛哥',
    '兵哥',
  ]
  @State private listData: Array<Person> = [
    new Person('张三', '男', '17610676602'),
    new Person('赵四', '女', '18927366363'),
    new Person('王五', '男', '15662537778'),
    new Person('李六', '女', '13987387728'),
    new Person('陈七', '男', '13182673827'),
    new Person('刘八', '女', '15762526636'),
  ]
  @State isEditMode: boolean = false
  @State selectedData: Person[] = []

  @Builder
  itemDeleteEnd(index: number) {
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
              // this.addData[]
              this.listData.push(new Person('增加的啊', '男', '18792728888'))
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
            // this.itemView2(item)
          }
          .margin(20)
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
        }, (item: Person) => item.key)
      }.width('100%')
      .divider({ strokeWidth: 2, color: Color.Brown, startMargin: 10, endMargin: 10 })
    }
    .width('100%')

  }

  @Builder
  itemView1(item: Person, index: number) {
    Row() {
      Text(item.name)
        .fontSize(20)
        .fontColor(this.listData[index].isSelect ? Color.Red : Color.Orange)
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
    .onClick(() => {
      // for (let i = 0; i < this.listData.length; i++) {
      //   this.listData[i].isSelect = i == index
      // }
      this.listData[index].isSelect = true
    })
  }

  @Builder
  itemView2(item: Person) {
    RelativeContainer() {
      Text(item.name)
        .fontColor(Color.Black)
        .fontSize(15)
        .alignRules({
          left: { anchor: '__container__', align: HorizontalAlign.Start },
          top: { anchor: '__container__', align: VerticalAlign.Top }
        })
        .onAreaChange((newValue: Area) => {
            item.itemHeight=newValue.height
        })
        .margin({ left: 10, top: 20 })
        .id('id_name')
      Text(item.sex)
        .fontColor(Color.Gray)
        .fontSize(13)
        .alignRules({
          top: { anchor: 'id_name', align: VerticalAlign.Bottom },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .onAreaChange((newValue: Area) => {
          item.itemHeight=newValue.height
        })
        .margin({ left: 10, top: 5 })
        .id('id_sex')
      Text(item.phone)
        .fontColor(Color.Red)
        .fontSize(12)
        .alignRules({
          top: { anchor: 'id_name', align: VerticalAlign.Bottom },
          left: { anchor: 'id_sex', align: HorizontalAlign.End }
        })
        .onAreaChange((newValue: Area) => {
          item.itemHeight=newValue.height
        })
        .margin({ left: 5, top: 5 })
        .id('id_phone')
      Image($r('app.media.img1'))
        .width(40)
        .height(40)
        .objectFit(ImageFit.Cover)
        .alignRules({
          left: { anchor: 'id_phone', align: HorizontalAlign.End },
          center: { anchor: 'id_phone', align: VerticalAlign.Center },
        })
        .id('id_avatar')
    }.width('100%')
    .borderColor(Color.Pink)
    .borderWidth(5)
  }
}

