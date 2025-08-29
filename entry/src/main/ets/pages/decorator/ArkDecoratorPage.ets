import { CommonTitle } from '../component/MyComponent'
import { promptAction } from '@kit.ArkUI'
import { MyButtonModifier } from '../ui/arkts/SetAttribute'

class TempClass {
  count: number = 0
}

@Entry
@Component
struct ArkDecoratorPage {
  private scroller: Scroller = new Scroller()
  @State handleCount: number = 0
  @State bgColor: ResourceColor = Color.Orange
  message: string = '父组件中的message'
  @State fontSizeChange: number = 13
  @State isEnable: boolean = true
  @State isFocus: boolean = true
  @State modifier: MyButtonModifier = new MyButtonModifier()

  build() {
    Scroll(this.scroller) {
      Column() {
        //1.局部自定义构建函数在组件内定义（build外），可以在组件内（build内的组件）和其他自定义构建函数中调用
        //2.全局自定义构建函数比局部多个function修饰，在文件的顶层中定义，可在任意组件和任意自定义构建函数中调用
        //3.自定义构建函数参数传递包括按值传递和按引用传递，可以直接使用当前使用处的状态变量this.xxx
        //4.@Builder按引用传递且仅传入一个参数时，才会触发动态渲染UI。如果@Builder传入的参数是两个或两个以上，不会触发动态渲染UI。
        //5.自定义构建函数多层嵌套时确保每层都是按引用参数传递，状态变量修改时才会进行UI刷新
        //6.@Builder结合V2装饰器的使用
        //7.@Builder中使用自定义组件，给自定义组件的传递参数为对象字面量形式并修改对象内的值时，UI触发刷新功能
        //https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-builder#在builder内创建自定义组件传递参数不刷新问题
        CommonTitle({ title: '1：@Builder装饰器：自定义构建函数\n以下参数均按引用传递' })

        this.customBuilderView({ count: this.handleCount })
        globalCustomBuilderView({ count: this.handleCount })
        globalCustomBuilderView1({ count: this.handleCount })
        Button('按引用传递参数-改变值')
          .onClick(() => {
            this.handleCount++
          })
        CommonTitle({ title: '1.1 @LocalBuilder装饰器：维持组件关系' })
        // this.localBuilderView({ count: this.handleCount })
        CustomTestLocalBuilderView({
          testLocalBuilderParam: this.localBuilderView1
        })

        CommonTitle({ title: '2：@BuilderParam装饰器：引用@Builder函数' })
        this.childTextView()
        CustomTexView({
          customBuilderParam0: this.childTextView,
          customBuilderParam1: () => {
            this.childTextView()
          }, customBuilderParam2: InnerTextView2
        })

        CommonTitle({ title: '3：wrapBuilder：封装全局@Builder' })
        //wrapBuilder方法只能传入全局@Builder方法。
        // wrapBuilder方法返回的WrappedBuilder对象的builder属性方法只能在struct内部使用。
        //使用场景1
        // 将wrapBuilder赋值给globalBuilder，且把MyBuilder作为wrapBuilder参数，
        // 用来替代MyBuilder不能直接赋值给globalBuilder。
        globalBuilder.builder('张三', 20)
        //使用场景2
        // 自定义组件Index使用ForEach来进行不同@Builder函数的渲染，
        // 可以使用builderArr声明的wrapBuilder数组进行不同@Builder函数效果体现。整体代码会较整洁。
        ForEach(globalBuilderArr, (item: WrappedBuilder<[string, number]>, index: number) => {
          item.builder('啦啦啦' + index, index + 10)
        })

        CommonTitle({ title: '4：@Styles装饰器：定义组件重用样式' })
        //1.当前@Styles仅支持通用属性和通用事件。
        //2.@Styles方法不支持参数
        //3.@Styles可以定义在组件内或全局，在全局定义时需在方法名前面添加function关键字，组件内定义时则不需要添加function关键字
        //4.不支持export
        //5.组件内@Styles的优先级高于全局@Styles。框架优先找当前组件内的@Styles，如果找不到，则会全局查找。
        //6.不支持在@Styles方法内使用逻辑组件，逻辑组件内的属性不生效。 if-else之类的
        Text('组件内的@Styles')
          .InnerStyles()
          .textAlign(TextAlign.Center)
        Text('全局的@Styles')
          .globalStyles()
          .textAlign(TextAlign.Center)
        Button('跨文件操作-动态属性设置')
          .attributeModifier(this.modifier)
          .onClick(() => {
            this.modifier.isDark = !this.modifier.isDark
          })


        CommonTitle({ title: '5：@Extend装饰器：定义扩展组件样式' })
        //1.和@Styles不同，@Extend支持封装指定组件的私有属性、私有事件和自身定义的全局方法。
        //2.仅支持全局定义，不支持组件内部定义。
        //3.@Extend装饰的方法支持参数，开发者可以在调用时传递参数，调用遵循TS方法传值调用。
        //4.@Extend装饰的方法的参数可以为function，作为Event事件的句柄。如：function xxx(onClick:()=>void){}。
        //5.@Extend的参数可以为状态变量，当状态变量改变时，UI可以正常的被刷新渲染。
        Text('扩展Text的组件样式')
          .myExtendText(this.fontSizeChange, () => {
            promptAction.showToast({ message: 'OK' })
            this.fontSizeChange += 1
          })

        CommonTitle({ title: '6：stateStyles：多态样式' })
        Button('按钮')
          .width(100)
          .height(100)
          .margin(20)
          .enabled(this.isEnable)
          .focusable(this.isFocus)
          .focusOnTouch(this.isFocus)
          .stateStyles({
            normal: {
              .backgroundColor(Color.Green)
            },
            focused: {
              .backgroundColor(Color.Orange)
            },
            clicked: {
              .backgroundColor(Color.Red)
            },
            disabled: {
              .backgroundColor(Color.Gray)
            },
            pressed: {
              .backgroundColor(Color.Pink)
            }
          })
        Row() {
          Button('是否可用').onClick(() => {
            this.isEnable = !this.isEnable
          })
          Button('是否有焦点').onClick(() => {
            this.isFocus = !this.isFocus
          }).margin({ left: 20 })
        }

        CommonTitle({ title: '7：@AnimatableExtend装饰器：定义可动画属性(在动画模块中示例)' })
        CommonTitle({ title: '8：@Require装饰器：校验构造传参（判断构造参数是否在初始化组件的时候必须传参）' })
        CommonTitle({ title: '9：@Reusable 组件复用' })
        //1.@Reusable装饰器仅用于自定义组件，与@Component结合使用。

      }
      .width('100%')
    }
    .width('100%')

  }

  //组件内部的@Styles,可以使用状态变量
  @Styles
  InnerStyles(){
    .width(100)
    .height(100)
    .backgroundColor(this.bgColor)
    .onClick(() => {
      this.bgColor = Color.Red
    })
    .margin(10)
    .borderColor(Color.Blue)
    .borderWidth(10)
    .borderRadius(8)
  }

  //@Builder装饰的自定义构建函数
  @Builder
  customBuilderView(param: TempClass) {
    Text(`局部@Builder：${param.count}`)
      .margin(10)
      .fontColor(Color.Orange)
      .fontSize(15)
  }

  //@LocalBuilder装饰的自定义构建函数
  @LocalBuilder
  localBuilderView(param: TempClass) {
    Row() {
      Text(`LocalBuilder：${param.count}`)
        .margin(10)
        .fontColor(Color.Blue)
        .fontSize(15)
    }
  }

  @LocalBuilder
  localBuilderView1(count: number) {
    Text(`LocalBuilder：${count}`)
      .margin(10)
      .fontColor(Color.Blue)
      .fontSize(15)
  }

  @Builder
  childTextView() {
    Text(this.message)
      .margin(10)
      .fontColor(Color.Gray)
      .fontSize(15)
  }
}

/**
 * @Extend 仅支持全局定义，不支持组件内部定义
 */
@Extend(Text)
function myExtendText(fonSize: number, onClick: () => void) {
  .width('100%')
  .padding(5)
  .margin(5)
  .textAlign(TextAlign.Center)
  .backgroundColor(Color.Pink)
  .fontColor(Color.Green)
  .fontSize(fonSize)
  .onClick(onClick)
}


//全局的样式，不支持传递参数
@Styles
function globalStyles() {
  .width(150)
  .height(150)
  .backgroundColor(Color.Green)
  .margin(10)
  .borderColor(Color.Red)
  .borderWidth(10)
  .borderRadius(8)
}

let globalBuilder: WrappedBuilder<[string, number]> = wrapBuilder(myGlobalBuilder);

let globalBuilderArr: WrappedBuilder<[string, number]>[] =
  [wrapBuilder(myGlobalBuilder1), wrapBuilder(myGlobalBuilder2)]

@Builder
function myGlobalBuilder(name: string, age: number) {
  Text(`这是一个全局的Builder:${name}-${age}`)
    .margin(10)
    .fontColor(Color.Pink)
    .fontSize(20)
}

@Builder
function myGlobalBuilder1(name: string, age: number) {
  Text(`这是一个全局的Builder:${name}-${age}`)
    .margin(10)
    .fontColor(Color.Red)
    .fontSize(20)
    .padding(3)
    .backgroundColor(Color.Yellow)
}

@Builder
function myGlobalBuilder2(name: string, age: number) {
  Text(`这是一个全局的Builder:${name}-${age}`)
    .margin(10)
    .fontColor(Color.Yellow)
    .fontSize(20)
    .padding(3)
    .backgroundColor(Color.Green)
}

@Builder
function globalCustomBuilderView(param: TempClass) {
  Text(`全局@Builder：${param.count}`)
    .margin(10)
    .fontColor(Color.Pink)
    .fontSize(15)
}

@Builder
function globalCustomBuilderView1(temp: TempClass) {
  Column() {
    Text(`全局@Builder中含有自定义组件：${temp.count}`)
      .margin(10)
      .fontColor(Color.Green)
      .fontSize(15)
    CustomComponentView({ count: temp.count })
  }
}

@Builder
function InnerTextView2(msg: string) {
  Text(msg).fontSize(15).fontColor(Color.Orange).backgroundColor(Color.Pink)
}

@Component
struct CustomComponentView {
  @Prop count: number

  build() {
    Column() {
      Text(`@Compomen自定义组件：${this.count}`)
        .fontColor(Color.Red)
        .margin(10)
        .fontSize(15)
    }

  }
}

@Component
struct CustomTestLocalBuilderView {
  count: number = 888

  @Builder
  InnerBuilder() {
    Text(`测试：${this.count}`).fontSize(15).fontColor(Color.Red).backgroundColor(Color.Yellow)
  }

  @BuilderParam testLocalBuilderParam: (count: number) => void = this.InnerBuilder

  build() {
    Column() {
      this.testLocalBuilderParam(111)
    }
  }
}

@Component
struct CustomTexView {
  message: string = '子组件中的message'
  //BuilderParam，用组件内部的自定义组件初始化
  @BuilderParam customBuilderParam0: () => void = this.InnerTextView0
  @BuilderParam customBuilderParam1: () => void = this.InnerTextView1
  @BuilderParam customBuilderParam2: (msg: string) => void // 这里没有初始化，但是使用的时候必须进行初始化

  @Builder
  InnerTextView0() {
  }

  @Builder
  InnerTextView1() {
  }

  @Builder
  InnerTextView2(msg: string) {
    Text(msg).fontSize(15).fontColor(Color.Orange).backgroundColor(Color.Pink)
  }

  build() {
    Column() {
      this.customBuilderParam0()
      this.customBuilderParam1()
      this.customBuilderParam2('这是一个带参数的BuilderParam')
    }.width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

