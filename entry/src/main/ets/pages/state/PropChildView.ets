@Observed
export class ChildClassA {
  name: string
  classB: ChildClassB

  constructor(name: string, classB: ChildClassB) {
    this.name = name;
    this.classB = classB;
  }
}

@Observed
export class ChildClassB {
  name: string

  constructor(name: string) {
    this.name = name
  }
}

@Component
export struct PropChildView {
  @Prop propNumber: number
  @Prop propString: string
  @Prop propBoolean: boolean
  @Prop propClassA: ChildClassA = new ChildClassA('classA-name', new ChildClassB('classB-name'))

  build() {
    Column() {
      Text(`子number：${this.propNumber}`).margin(10).fontSize(15)
      Text(`子string：${this.propString}`).margin(10).fontSize(15)
      Text(`子boolean：${this.propBoolean}`).margin(10).fontSize(15)
      Button('改变子中的值').onClick(() => {
        this.propNumber += 2
        this.propString = 'H哈哈哈哈哈'
        this.propBoolean = !this.propBoolean
      })

      Text(`子classA：${this.propClassA.name}--${this.propClassA.classB.name}`).margin(10).fontSize(15)
      PropChild2View({
        propClassB: this.propClassA.classB
      })
      Button('改变子ClassA值').onClick(() => {
        this.propClassA.name = '333333'
        this.propClassA.classB.name = '444444'
      })
    }
    .width('100%')
  }
}

@Component
struct PropChild2View {
  @Prop propClassB: ChildClassB = new ChildClassB('我是嵌套classB的name')

  build() {
    Text(`嵌套的子View：${this.propClassB.name}`).margin(10).fontSize(15).fontColor(Color.Red)
  }
}