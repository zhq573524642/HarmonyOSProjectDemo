import router from '@ohos.router'

@Entry
@Component
struct Second {
  @State message: string = 'Hello World'
  @State private buttonColor: Color = Color.Green

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button() {
          Text('页面2的按钮')
            .fontSize(20)
            .fontColor(Color.Green)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .backgroundColor('#ff00ff')
        .margin({
          top: 30, bottom: 30
        })
        .width('50%')
        .height('5%')
        .onClick(() => {
          console.info('第二个页面点击按钮成功')
          try {
            router.back()
            console.info('第二个页面返回成功')
          } catch (e) {
            console.error('返回第一个页面错误：${e.code}--${e.message}')
          }
        })

        Button() {
          Text('按钮2')
            .fontColor(Color.Blue)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontStyle(FontStyle.Italic)
        }
        .type(ButtonType.Circle)
        .backgroundColor(this.buttonColor)
        .onClick(() => {
          this.buttonColor = Color.Red
          router.pushUrl({ url: 'pages/StudyView' })
        })
        .width('60%')
        .height('20%')
        // .onClick(function(){
        //   //...
        // }.bind(this))
        // .onClick(this.myClick.bind(this))
        // .onClick(this.fn)
      }
      // .width('100%')

    }
    .height('100%')
  }

  //成员函数
  myClick(): void {
    //...
  }
  //声明的箭头函数,不需要bind(this)
  fn = () => {
    //...
  }
}