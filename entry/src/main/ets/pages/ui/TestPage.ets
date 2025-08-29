@Entry
@Component
struct TestPage {
  @State title: string = 'Parent-Page'

  @Builder ParentBuilder1(){
    Text(this.title)
      .fontColor(Color.Red)
  }
  @Builder ParentBuilder2(title:string){
    Text(title)
      .fontColor(Color.Green)
  }

  build() {
    Column({ space: 10 }) {
      this.ParentBuilder1()//this指向父组件（Parent-Page）
      this.ParentBuilder2(this.title)//this指向父组件（Parent-Page）
      MyComponent({
        myFunction1:this.ParentBuilder1//赋值方法：局部@Builder，this指向子组件 （Child-Page）
      ,myFunction2:(title:string):void=>{
         this.ParentBuilder2(this.title)//箭头函数：局部@Builder，this指向父组件（Parent-Page）
      }})
    }
    .height('100%')
    .width('100%')
  }
}


@Builder
function MyBuilder3() {
    Text('全局：').fontColor(Color.Pink)
}


@Component
struct MyComponent {
  title:string='Child-Page'
  @Builder
  MyBuilder1() {
  }
  @Builder
  MyBuilder2(title:string) {
  }

  @BuilderParam myFunction1: () => void = this.MyBuilder1
  @BuilderParam myFunction2: (title: string) => void = this.MyBuilder2

  build() {
    Column() {
      this.myFunction1()
      this.myFunction2('a')
    }.width('100%')
  }
}


class TextTemp {
  title: string = ''
  titleColor: ResourceColor = Color.Red
}

@Builder
function TextBuilder1(textTemp: TextTemp) {
  Text(textTemp.title)
    .fontSize(15)
    .fontColor(textTemp.titleColor)
}

@Builder
function TextBuilder2(title: string, titleColor: ResourceColor) {
  Text(title)
    .fontSize(15)
    .fontColor(titleColor)
}