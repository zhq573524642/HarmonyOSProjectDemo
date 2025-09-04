import { RouterUtil } from '@ohos/common'

@Entry({ routeName: "ObservedLinkClassPage" })
@Component
export struct ObservedLinkClassPage {
  @State classA: Class_A = new Class_A(1, new Class_B(1, new Class_C(1)))

  static startPage() {
    RouterUtil.pushNamedRoute('ObservedLinkClassPage')
  }

  build() {
    Column({ space: 10 }) {
      Text('A->B->C:每层嵌套使用单独的组件接收并渲染\n点击按钮和文本修改数据，实现双向同步')
      MyComponentA({ classA: this.classA })
      MyComponentB({ classB: this.classA.classB })
      MyComponentC({ classC: this.classA.classB.classC })
      Button('改变A：+1').onClick(() => {
        this.classA.size++
      })
      Button('改变B：+2').onClick(() => {
        this.classA.classB.size += 2
      })
      Button('改变C：+3').onClick(() => {
        this.classA.classB.classC.size += 3
      })
    }.margin({ top: 20 })
    .width('100%')
  }
}

@Component
struct MyComponentA {
  @ObjectLink classA: Class_A

  build() {
    Column() {
      Text(`A：${this.classA.size}`).fontColor(Color.Blue).fontSize(20)
        .onClick(() => {
          this.classA.size++
        })
    }.padding(10)
    .borderColor(Color.Red)
    .borderWidth(2)
  }
}

@Component
struct MyComponentB {
  @ObjectLink classB: Class_B

  build() {
    Column() {
      Text(`B：${this.classB.size}`).fontColor(Color.Green).fontSize(20)
        .onClick(() => {
          this.classB.size += 2
        })
    }.padding(10)
    .borderColor(Color.Yellow)
    .borderWidth(2)
  }
}

@Component
struct MyComponentC {
  @ObjectLink classC: Class_C

  build() {
    Column() {
      Text(`C：${this.classC.size}`).fontColor(Color.Pink).fontSize(20)
        .onClick(() => {
          this.classC.size += 3
        })
    }
    .borderColor(Color.Orange)
    .borderWidth(2)
    .padding(10)
  }
}


let NextId: number = 1

@Observed
class Class_A {
  id: number
  size: number
  classB: Class_B

  constructor(size: number, classB: Class_B) {
    this.id = NextId++
    this.size = size
    this.classB = classB
  }
}

@Observed
class Class_B {
  size: number
  classC: Class_C

  constructor(size: number, classC: Class_C) {
    this.size = size
    this.classC = classC
  }
}

@Observed
class Class_C {
  size: number

  constructor(size: number) {
    this.size = size
  }
}



