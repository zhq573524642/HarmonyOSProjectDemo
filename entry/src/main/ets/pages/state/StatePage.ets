import { CommonTitle } from '../component/MyComponent';
import map from '@hms.core.map.map';

class ClassA {
  name: string

  constructor(name: string) {
    this.name = name
  }
}

class ClassB {
  name: string
  classA: ClassA

  constructor(name: string, classA: ClassA) {
    this.name = name;
    this.classA = classA;
  }
}

class TestData {
  name: string
  selected: boolean

  constructor(name: string, selected: boolean) {
    this.name = name;
    this.selected = selected;
  }
}

@Entry
@Component
struct StatePage {
  @Styles
  MyButtonStyles() {
    .margin({ left: 10, bottom: 10, right: 10 })
  }

  private scroller: Scroller = new Scroller()
  private scrollerList: Scroller = new Scroller()
  @State stateString: string = 'Hello World';
  @State stateNumber: number = 1;
  @State stateBoolean: boolean = false;
  @State stateClass: ClassB = new ClassB('B_name', new ClassA('A_name'))
  @State stateArrayList: Array<TestData> = [
    new TestData('Item-0', true),
    new TestData('Item-1', false),
    new TestData('Item-2', false),
    new TestData('Item-3', false),
    new TestData('Item-4', false)
  ]
  @State stateMap: Map<number, string> = new Map([
    [0, 'Item-0'],
    [1, 'Item-1'],
    [2, 'Item-2'],
    [3, 'Item-3'],
    [4, 'Item-4']
  ])
  stateArrayListTemp: Array<TestData> = []

  aboutToAppear(): void {
    this.stateArrayListTemp = this.stateArrayList
  }

  build() {

    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '1、State：string/number/boolean' })
        Row() {
          Button(this.stateString)
            .onClick(() => {
              this.stateString = 'Hello World  Change'
            })
          Button(`${this.stateNumber}`)
            .onClick(() => {
              this.stateNumber++
            })
          Button(`${this.stateBoolean}`)
            .onClick(() => {
              this.stateBoolean = !this.stateBoolean
            })
        }.justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')

        CommonTitle({ title: '2、State：Object/class' })
        Text(`ClassB中name：${this.stateClass.name}`).fontColor(Color.Black).fontSize(16).margin(10)
        Text(`ClassB中ClassA中name：${this.stateClass.classA.name}`).fontColor(Color.Black).fontSize(16).margin(10)
        Button('改变整个ClassB')
          .onClick(() => {
            this.stateClass = new ClassB('B_name1', new ClassA('A_name1'))
          })
          .MyButtonStyles()
        Button('改变ClassB中name的值')
          .onClick(() => {
            this.stateClass.name = 'B_name2'
          })
          .MyButtonStyles()
        Button('改变ClassB中ClassA值')
          .onClick(() => {
            this.stateClass.classA = new ClassA('A_name3')
          })
          .MyButtonStyles()
        Button('改变ClassB中ClassA中name值(不会更新UI)')
          .onClick(() => {
            this.stateClass.classA.name = 'A_name4'
          })
          .MyButtonStyles()

        CommonTitle({ title: '3、State：数组' })
        Row() {
          Button('增').onClick(() => {
            this.stateArrayList.push(new TestData('item-新增', false))
          })
          Button('删').onClick(() => {
            this.stateArrayList.pop()
          })
          Button('修改item0').onClick(() => {
            this.stateArrayList[0] = new TestData('item-0-修改', true)
          })
        }.margin({ bottom: 15 })
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        List({ scroller: this.scrollerList }) {
          ForEach(this.stateArrayList, (item: TestData, index: number) => {
            ListItem() {
              Row() {
                Text(`${item.name}`).fontColor(item.selected ? Color.White : Color.Black)
              }
              .alignItems(VerticalAlign.Center)
              .backgroundColor(item.selected ? Color.Red : Color.White)
              .borderWidth(1)
              .borderColor(item.selected ? Color.Yellow : Color.Gray)
              .width('100%')
              .height(40)
              .margin({ left: 15, right: 15, bottom: 8 })
              .onClick(() => {
                //TODO （效果点击每个item独立改变状态）
                //方式1：不会改变
                // item.selected = !item.selected
                // this.stateArrayList[index] = item
                //方式2：不会改变
                // for (let i = 0; i < this.stateArrayList.length; i++) {
                //   if (i == index) {
                //     this.stateArrayList[i].selected = !this.stateArrayList[i].selected
                //   }
                // }
                //方式3：可改变（效果每个item独立改变）
                // let tempArr: Array<TestData> = []
                // for (let i = 0; i < this.stateArrayList.length; i++) {
                //   if (i == index) {
                //     this.stateArrayList[i].selected = !this.stateArrayList[i].selected
                //   }
                //   tempArr.push(this.stateArrayList[i])
                // }
                // this.stateArrayList = tempArr
                //方式4：不会改变
                // let tempItem: TestData = new TestData('', false)
                // for (let i = 0; i < this.stateArrayList.length; i++) {
                //   if (i == index) {
                //     this.stateArrayList[i].selected = !this.stateArrayList[i].selected
                //     tempItem = this.stateArrayList[i]
                //   }
                // }
                // this.stateArrayList[index] = tempItem
                //方式5：可改变
                // let tempItem: TestData = new TestData('', false)
                // for (let i = 0; i < this.stateArrayList.length; i++) {
                //   if (i == index) {
                //     this.stateArrayList[i].selected = !this.stateArrayList[i].selected
                //     tempItem = this.stateArrayList[i]
                //   }
                // }
                // this.stateArrayList[index] = new TestData(tempItem.name,tempItem.selected)
                //TODO (效果点击整个列表只有一个item被选中)
                //方式1：不会改变
                // for (let i = 0; i < this.stateArrayListTemp.length; i++) {
                //   this.stateArrayListTemp[i].selected = i == index
                // }
                // this.stateArrayList = this.stateArrayListTemp
                //方式2：可以改变
                let temArr: Array<TestData> = []
                for (let i = 0; i < this.stateArrayListTemp.length; i++) {
                  this.stateArrayListTemp[i].selected = i == index
                  temArr.push(this.stateArrayListTemp[i])
                }
                this.stateArrayList = temArr

              })
            }
          })
        }.width('100%')
        .listDirection(Axis.Vertical)

        CommonTitle({ title: '4、State：Map' })
        Row() {
          Button('增')
            .onClick(() => {
              let size: number = this.stateMap.size
              this.stateMap.set(size - 1, `新增Item-${size - 1}`)
            })
            .MyButtonStyles()
          Button('删 key=0')
            .onClick(() => {
              this.stateMap.delete(0)
            })
            .MyButtonStyles()
          Button('改 key=1')
            .onClick(() => {
              this.stateMap.set(1, '修改Item-1')
            })
            .MyButtonStyles()
          Button('清空')
            .onClick(() => {
              this.stateMap.clear()
            })
            .MyButtonStyles()
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        List({ scroller: this.scrollerList }) {
          ForEach(Array.from(this.stateMap), (item: [number, string], index: number) => {
            ListItem() {
              Row() {
                Text(`${item?.[1]}`).fontColor(Color.Black)
              }
              .alignItems(VerticalAlign.Center)
              .backgroundColor(Color.White)
              .borderWidth(1)
              .borderColor(Color.Gray)
              .width('100%')
              .height(40)
              .margin({ left: 15, right: 15, bottom: 8 })
            }
          })
        }.width('100%')
        .listDirection(Axis.Vertical)
      }
      .width('100%')
    }.width('100%')
    .scrollable(ScrollDirection.Vertical)

  }
}
