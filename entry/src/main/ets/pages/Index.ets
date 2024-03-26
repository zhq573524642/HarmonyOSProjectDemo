import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: number = 0

  build() {
    Row() {

      Column() {
        Row() {
          Text('计数：' + this.message)
            .fontStyle(FontStyle.Normal)
            .fontColor(Color.Yellow)
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .width('80%')
            .textAlign(TextAlign.Center)
            .backgroundColor(Color.Orange)
            .margin(20)
        }
        .alignItems(VerticalAlign.Center)
        // .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Pink)
        .borderStyle(BorderStyle.Dotted)
        .borderColor(Color.Blue)
        .borderRadius(15)
        .borderWidth(3)
        .margin({
          top: 20, left: 20, right: 20, bottom: 20
        })
        .width('80%')
        .height('20%')

        Button() {
          Text('点击累加')
            .fontColor(Color.Red)
            .fontSize(20)
        }
        .type(ButtonType.Normal)
        .padding(10)
        .onClick(() => {
          this.message = this.message + 1
        })

        Button() {
          Text('跳转Second页面')
            .fontSize(20)
            .fontColor('#ff0000')
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20, bottom: 20
        })
        .backgroundColor('#00ffff')
        .width('80%')
        .height('5%')
        .onClick(() => {
          console.info('点击了按钮')
          router.pushUrl({ url: 'pages/Second' }).then(() => {
            console.info('成功跳转到第二个页面')
          }).catch((error) => {
            console.error('跳转失败：${error.code},--${error.message}')
          })
        })
      }
      .backgroundColor(Color.Green)
      .width('100%')
      .height('100%')
    }
    .height('100%')
  }
}