import { ObservedArray } from '../../utils/ObservedArray'
import { Person } from './Person'
import { LengthMetrics, promptAction } from '@kit.ArkUI'
import { util } from '@kit.ArkTS'

@Entry
@Component
struct ArrayTestPage {
  @State private personArray: ObservedArray<Person> = new ObservedArray<Person>()
  private nameArr: string[] = ['张三', '李四', '王五', '赵六']
  @State selectedItem: Person = new Person()

  aboutToAppear(): void {
    for (let i = 0; i < this.nameArr.length; i++) {
      let person = new Person()
      person.name = this.nameArr[i]
      person.age = i + 18
      if (i === 0) {
        this.selectedItem = person
      }
      this.personArray.push(person)
    }
  }

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.personArray, (item: Person, index?: number) => {
          ListItem() {
            Row({ space: 10 }) {
              Text(item.name).fontColor(Color.Black).fontSize(16)
              Text(`${item.age}岁`).fontColor(Color.Gray).fontSize(13)
            }
            .width('90%')
            .height(50)
            .borderWidth(5)
            .borderColor(this.selectedItem?.name === item.name ? Color.Green : Color.White)
            .backgroundColor(Color.White)
            .padding({ left: 10 })
          }
          .onClick(() => {
            this.selectedItem = item
          })
        }, (item: Person) => item.name)
      }.width('100%')
      .alignListItem(ListItemAlign.Center)
      .margin({ top: 10, bottom: 10 })

      Flex({
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap,
        alignItems: ItemAlign.Auto,
        space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) }
      }) {
        this.MyButton('新增push', () => {
          let person = new Person()
          person.name = '孙七' + util.generateRandomUUID()
          person.age = 28
          this.personArray.push(person)
        })
        this.MyButton('删除pop', () => {
          this.personArray.pop()
        })
        this.MyButton('元素用特殊字符拼接join', () => {
          let result = this.nameArr.join('-')
          promptAction.showToast({ message: result })
        })
        this.MyButton('是否存在某元素indexOf', () => {
          let index = this.personArray.indexOf(this.selectedItem)
          promptAction.showToast({ message: index + '' })
        })
      }.padding({ left: 10, right: 10 })
    }
    .backgroundColor('#f5f5f5')
    .width('100%')
    .height('100%')
  }

  everyFunc(item: Person, index: number, array: ObservedArray<Person>): boolean {
    return (item.age > 10)
  }

  @Builder
  MyButton(text: string, click?: () => void) {
    Button(text)
      .fontSize(13)
      .fontWeight(FontWeight.Medium)
      .onClick(() => {
        click?.()
      })
  }
}

