import observer from '@ohos.arkui.observer';

@Component
export struct NavDialogPage {
  @Consume('NavPathStack') pageStack: NavPathStack
  @State paramsStr: string = ''

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text("Dialog NavDestination")
            .fontSize(20)
          Text(this.paramsStr)
            .fontSize(15)
            .margin({ top: 10, bottom: 80 })
          Button("Close").onClick(() => {
            this.pageStack.pop()
          }).width('30%')
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .height('30%')
        .width('80%')
      }.height("100%").width('100%')
    }
    .backgroundColor('rgba(0,0,0,0.5)')
    .hideTitleBar(true)
    .mode(NavDestinationMode.DIALOG)
    .onReady((context: NavDestinationContext) => {
      if (context?.pathInfo?.param) {
        let p = context?.pathInfo?.param as Record<string, Object>
        this.paramsStr = p.name + '--' + p.age
      }
    })
  }
}