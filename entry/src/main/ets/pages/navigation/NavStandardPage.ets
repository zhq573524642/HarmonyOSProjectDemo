import observer from '@ohos.arkui.observer';

@Component
export struct NavStandardPage {
  @Consume('NavPathStack') pageStack: NavPathStack
  @State pathStackSize: number = 0
  @State pageParam: string = ''

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column({ space: 15 }) {
          Text("Standard NavDestination：\n" +
            '当前NavPathStackSize：' + this.pathStackSize + '\n' +
            '当前Index：' + (this.pathStackSize - 1) + '\n' +
            '参数：' + this.pageParam)
            .fontSize(20)
          Button("pushName:NavStandardPage").onClick(() => {
            this.pageStack.pushPathByName('NavStandardPage', 'AAA-'+this.pathStackSize)
          }).width('90%')
          Button("replacePath:NavStandardPage").onClick(() => {
            this.pageStack.replacePath({
              name: 'NavStandardPage',
              param:'BBB-'+this.pathStackSize
            })
          }).width('90%')
          Button("removeByIndexes:[0,1]").onClick(() => {
            this.pageStack.removeByIndexes([0, 1])
          }).width('90%')
          Button("pop").onClick(() => {
            this.pageStack.pop()
          }).width('90%')
          Button("popToName").onClick(() => {
            this.pageStack.popToName('NavStandardPage')
          }).width('90%')
          Button("popToIndex:0").onClick(() => {
            this.pageStack.popToIndex(0)
          }).width('90%')
          Button("StackClear").onClick(() => {
            this.pageStack.clear()
          }).width('90%')

        }
        .justifyContent(FlexAlign.Start)
        .backgroundColor(Color.White)
        .borderRadius(10)
      }.height("100%").width('100%')
    }
    .hideTitleBar(true)
    .mode(NavDestinationMode.STANDARD)
    .geometryTransition('shareId1')

    //生命周期
    // .onWillAppear(() => {
    //   console.debug('===NavDestination-onWillAppear')
    // })
    // .onAppear(() => {
    //   console.debug('===通用-onAppear')
    // })
    // .onWillShow(() => {
    //   console.debug('===NavDestination-onWillShow')
    // })
    // .onShown(() => {
    //   console.debug('===NavDestination-onShown')
    // })
    // .onWillHide(() => {
    //   console.debug('===NavDestination-onWillHide')
    // })
    // .onHidden(() => {
    //   console.debug('===NavDestination-onHidden')
    // })
    // .onWillDisappear(() => {
    //   console.debug('===NavDestination-onWillDisappear')
    // })
    // .onDisAppear(() => {
    //   console.debug('===通用-onDisappear')
    // })
  }

  aboutToAppear(): void {
   let info= this.queryNavDestinationInfo()
    this.pathStackSize = this.pageStack.size()
    this.pageParam = this.pageStack.getParamByIndex(this.pathStackSize - 1) as string
    // console.debug('===自定义组件-aboutToAppear')
    // observer.on('navDestinationUpdate', (info) => {
    //   console.info('===NavDestination state update', JSON.stringify(info));
    // });
  }

  aboutToDisappear(): void {
    // console.debug('===自定义组件-aboutToDisappear')
  }
}