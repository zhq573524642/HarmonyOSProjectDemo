import router from '@ohos.router';
import { CircleView } from '../pages/component/TitleComponent'
import { CommonButton, CommonTitle } from './component/MyComponent';

@Entry
@Component
struct Index {
  @State message: number = 0
  @State circleBgColor: Color = Color.Red
  @State setW: number = 50
  @State setH: number = 50
  @State showBackParam: string = '页面返回参数在这里显示'

  build() {
    //垂直布局
    Column() {
      //滚动布局
      Scroll() {
        //滚动布局里面有个垂直的子View
        Column() {
          //水平布局1
          Row() {
            Column() {
              CommonButton({ text: '布局' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/LayoutPage' })
                })
              CommonButton({ text: '常用组件' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/CommonComponentPage' })
                })
              CommonButton({ text: '视频播放' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/VideoPlayPage' })
                })
              CommonButton({ text: '气泡和菜单' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/PopupMenuPage' })
                })
              Text(this.showBackParam)
                .margin(8)
                .fontSize(15)
              CommonButton({ text: 'router页面跳转并传递参数' })
                .onClick(() => {
                  jumpPageWithParams()
                })
              CommonButton({ text: '顶部Tabs' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/TabsPage',
                    params: {
                      tabType: 1
                    } })
                })
              CommonButton({ text: '底部Tabs' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/TabsPage',
                    params: {
                      tabType: 2
                    } })
                })
              CommonButton({ text: '自定义底部Tabs' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/TabsPage',
                    params: {
                      tabType: 3
                    } })
                })
              CommonButton({ text: '图片显示Image' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/ImagePage' })
                })
              CommonButton({ text: '几何图形Shape' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/ShapePage' })
                })
              CommonButton({ text: '动画' })
                .onClick(() => {
                  router.pushUrl({ url: 'pages/AnimationPage' })
                })
              //带边框的View
              Column() {
                //文本View
                Text('计数：' + this.message)
                  .fontStyle(FontStyle.Italic) //字体样式 正常/斜体
                  .fontColor(Color.Yellow) //字体颜色
                  .fontSize(30) //字体大小
                  .fontWeight(FontWeight.Bold) //字体权重 加粗等
                  .width('80%')
                  .textAlign(TextAlign.Center)
                  .backgroundColor(Color.Orange) //文本View背景色
                  .margin(20)
              }
              .alignItems(HorizontalAlign.Center)
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
                Text($r('app.string.app_name'))
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

              //自定组件引入
              CircleView({ bgColor: $circleBgColor, w: $setW, h: $setH })
                .margin({ top: 20 })
              Button() {
                Text('点击自定义组件变化')
              }
              .onClick(() => {
                this.setW = this.setW + 10
                this.setH = this.setH + 10
                this.circleBgColor = Color.Green
              })
              .margin({ top: 10 })

              //自定义组件2
              TitleView({ text: 'aaaa' })
                .margin({
                  top: 20
                })

            }
            .alignItems(HorizontalAlign.Center) //垂直布局在水平方向的位置
            .backgroundColor(Color.Green)
            .width('100%')
            .height('100%')
          }
          .alignItems(VerticalAlign.Center) //水平布局在垂直方向的位置
          .width('100%')
        }
        .width('100%')

      }

    }

  }

  aboutToAppear() {
    console.log('===创建组件实例-build之前')
  }

  aboutToDisappear() {
    console.log('===销毁组件实例')
  }

  onPageShow() {
    console.log('===页面打开')
    let params = router.getParams()
    this.showBackParam = params?.['name']

  }

  onPageHide() {
    console.log('===页面关闭')
  }

  onBackPress() {
    console.log('===点击返回')
    return false
  }
}

class Person {
  name: string;
  age: number;
}

class Student {
  id: number;
  info: Person;
}

function jumpPageWithParams() {
  let student: Student = {
    id: 12,
    info: {
      name: '张三',
      age: 18
    }
  }

  router.pushUrl({ url: 'pages/Second',
    params: student }, router.RouterMode.Single, (error) => {

  })
}

@Component
struct TitleView {
  private text: string

  //组件内的自定义构建函数
  // @Builder innerComponent() {
  //
  // }

  build() {
    Text(this.text)
      .fontSize(20)
      .fontColor(Color.Red)
      .fontStyle(FontStyle.Italic)
    //调用自定义组件内部的自定义构建函数
    // this.innerComponent()
    //调用全局的自定义构建函数
    // AppComponentView()

  }
}

// //全局的自定义构建函数
// @Builder function AppComponentView() {
//
// }