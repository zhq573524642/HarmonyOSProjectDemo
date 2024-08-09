import { CommonTitle } from '../component/MyComponent'
import { promptAction } from '@kit.ArkUI'

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

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '1：@Builder装饰器：自定义构建函数' })
        this.customBuilderView({ count: this.handleCount })
        globalCustomBuilderView({ count: this.handleCount })
        globalCustomBuilderView1({ count: this.handleCount })
        Button('按引用传递参数-改变值')
          .onClick(() => {
            this.handleCount++
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
        Text('组件内的@Styles')
          .InnerStyles()
          .textAlign(TextAlign.Center)
        Text('全局的@Styles')
          .globalStyles()
          .textAlign(TextAlign.Center)

        CommonTitle({ title: '5：@Extend装饰器：定义扩展组件样式' })
        Text('扩展Text的组件样式')//仅支持全局定义，不支持在组件内部定义
          .myExtendText(this.fontSizeChange, () => {
            promptAction.showToast({ message: 'OK' })
            this.fontSizeChange += 1
          })

        CommonTitle({ title: '6：stateStyles：多态样式' })
        Button('按钮').width(100).height(100).margin(20)
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
         Row(){
           Button('是否可用').onClick(()=>{
             this.isEnable=!this.isEnable
           })
           Button('是否有焦点').onClick(()=>{
             this.isFocus=!this.isFocus
           }).margin({left:20})
         }

        CommonTitle({title:'7：@AnimatableExtend装饰器：定义可动画属性(在动画模块中示例)'})
        CommonTitle({title:'8：@Require装饰器：校验构造传参（判断构造参数是否在初始化组件的时候必须传参）'})

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

  //@Builder装饰的自定义组件
  @Builder
  customBuilderView(param: TempClass) {
    Text(`局部@Builder：${param.count}`)
      .margin(10)
      .fontColor(Color.Orange)
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
 * @Extend  仅支持全局定义，不支持组件内部定义
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

let globalBuilderArr: WrappedBuilder<[string, number]>[] = [wrapBuilder(myGlobalBuilder1), wrapBuilder(myGlobalBuilder2)]

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
function globalCustomBuilderView1($$: TempClass) {
  Column() {
    Text(`全局@Builder中含有自定义组件：${$$.count}`)
      .margin(10)
      .fontColor(Color.Green)
      .fontSize(15)
    CustomComponentView({ count: $$.count })
  }
}

@Builder
function InnerTextView2(msg: string) {
  Text(msg).fontSize(15).fontColor(Color.Orange).backgroundColor(Color.Pink)
}

@Component
struct CustomComponentView {
  @Link count: number

  build() {
    Text(`@Compomen自定义组件：${this.count}`)
      .fontColor(Color.Red)
      .margin(10)
      .fontSize(15)
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

