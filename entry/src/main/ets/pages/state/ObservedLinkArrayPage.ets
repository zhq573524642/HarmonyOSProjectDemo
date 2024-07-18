@Entry
@Component
struct ObservedLinkArrayPage {
  @State classArr: Array<ClassA> = [new ClassA(11), new ClassA(22), new ClassA(33), new ClassA(44)]

  build() {
    Column({ space: 10 }) {
      Column() {
        ForEach(this.classArr, (item: ClassA) => {
          ViewArrayA({ classA: item })
        }, (item: ClassA) => item.id + '')
      }.padding(10)
      .width('80%')
      .borderWidth(5)
      .borderColor(Color.Yellow)

      Text(`第一个元素：${this.classArr[0].a}`).fontSize(18).fontColor(Color.Orange)
        .margin(10)
      Text(`最后一个元素：${this.classArr[this.classArr.length-1].a}`).fontSize(18).fontColor(Color.Pink)
        .margin(10)
      Button('重新赋值数组')
        .onClick(() => {
          this.classArr = [new ClassA(111), new ClassA(222), new ClassA(333), new ClassA(444)]
        })
      Button('数组最后增加一个元素')
        .onClick(() => {
          this.classArr.push(new ClassA(55))
        })
      Button('删除数组最后一个元素')
        .onClick(() => {
          this.classArr.splice(this.classArr.length - 1, 1)
        })
      Button('改变第一个元素的值')
        .onClick(() => {
          this.classArr[0] = new ClassA(100)
        })
      Button('改变第一个元素的值a')
        .onClick(() => {
          this.classArr[0].a = 200
        })
      Button('改变第一个元素的值isSelected')
        .onClick(() => {
          this.classArr[0].isSelected = !this.classArr[0].isSelected
        })
    }.width('100%')
  }
}

@Component
struct ViewArrayA {
  @ObjectLink classA: ClassA

  build() {
    Text(`item：${this.classA.a}`).fontSize(18).fontColor(this.classA.a % 2 === 0 ? Color.Red : Color.Green)
      .margin(10)
      .backgroundColor(this.classA.isSelected ? Color.Pink : Color.Transparent)
      .onClick(()=>{
        this.classA.isSelected=!this.classA.isSelected
      })
  }
}

let NextID: number = 1

@Observed
class ClassA {
  a: number
  isSelected: boolean = false
  id: number

  constructor(a: number) {
    this.id = NextID++
    this.a = a;
  }
}
