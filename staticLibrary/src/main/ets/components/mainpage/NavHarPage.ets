import observer from '@ohos.arkui.observer';


// 跳转页面入口函数
@Builder
export function PageHarBuilder() {
  NavHarPage()
}

@Component
struct NavHarPage {
  pageStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text("Har包中的页面：\n" +
            '参数：')
            .fontSize(20)
            .margin({ bottom: 100 })
          Button("Close").onClick(() => {
            this.pageStack.pop()
          }).width('30%')
        }
        .justifyContent(FlexAlign.Start)
        .backgroundColor(Color.White)
        .borderRadius(10)
      }.height("100%").width('100%')
    }
    .hideTitleBar(true)
    .mode(NavDestinationMode.STANDARD)
    .onReady((context:NavDestinationContext)=>{
       this.pageStack=context.pathStack
    })
  }
}