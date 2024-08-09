import observer from '@ohos.arkui.observer';

@Component
export struct NavDialogPage {
  @Consume('NavPathStack') pageStack: NavPathStack
  navDesInfo: observer.NavDestinationInfo | undefined

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text("Dialog NavDestination")
            .fontSize(20)
            .margin({ bottom: 100 })
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
  }

  aboutToAppear(): void {
    let params = this.pageStack.getParamByName('NavDialogPage').toString()
    console.debug('===参数：'+params)
    this.navDesInfo = this.queryNavDestinationInfo()
    observer.on('navDestinationUpdate', (info: NavDestinationInfo) => {
      info.param
      // console.info('===NavDestination state update', JSON.stringify(info));
    });
  }
}