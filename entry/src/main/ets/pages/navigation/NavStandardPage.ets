import observer from '@ohos.arkui.observer';

@Component
export struct NavStandardPage {
  @Consume('NavPathStack') pageStack: NavPathStack
  @State pathStackSize: number = 0
  @State pageParam: string = ''
  navDestinationInfo: NavDestinationInfo | undefined

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column({ space: 15 }) {
          Text("Standard NavDestination：\n" +
            '页面信息：' + this.navDestinationInfo?.name + "\n" +
            '当前NavPathStackSize：' + this.pathStackSize + '\n' +
            '当前Index：' + (this.pathStackSize - 1) + '\n' +
            '参数：' + JSON.stringify(this.pageParam))
            .fontSize(20)
          Button("pushName:NavStandardPage").onClick(() => {
            this.pageStack.pushPathByName('NavStandardPage', 'AAA-' + this.pathStackSize)
          }).width('90%')
          Button("replacePath:NavStandardPage").onClick(() => {
            this.pageStack.replacePath({
              name: 'NavStandardPage',
              param: 'BBB-' + this.pathStackSize
            })
          }).width('90%')
          Button("pop").onClick(() => {
            this.pageStack.pop(true)
          }).width('90%')
          Button("popWithResult").onClick(() => {
            this.pageStack.pop('aaaaaaaaaaaaaaA', true)
          }).width('90%')
          Button("popToName").onClick(() => {
            this.pageStack.popToName('NavStandardPage')
          }).width('90%')
          Button("popToNameWithResult").onClick(() => {
            this.pageStack.popToName('NavStandardPage', 'aaaaab', true)
          }).width('90%')
          Button("popToIndex:0").onClick(() => {
            this.pageStack.popToIndex(0)
          }).width('90%')
          Button("StackClear").onClick(() => {
            this.pageStack.clear()
          }).width('90%')
          Button("removeByName").onClick(() => {
            this.pageStack.removeByName('NavStandardPage')
          }).width('90%')
          Button("removeByIndexes:[0,1]").onClick(() => {
            this.pageStack.removeByIndexes([0, 1])
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
    .onWillAppear(() => {
      console.debug('===NavDestination-onWillAppear:' + this.pageStack.size())
    })
    .onAppear(() => {
      console.debug('===通用-onAppear:' + this.pageStack.size())
    })
    .onWillShow(() => {
      console.debug('===NavDestination-onWillShow:' + this.pageStack.size())
    })
    .onShown(() => {
      console.debug('===NavDestination-onShown:' + this.pageStack.size())
    })
    .onWillHide(() => {
      console.debug('===NavDestination-onWillHide:' + this.pageStack.size())
    })
    .onHidden(() => {
      console.debug('===NavDestination-onHidden:' + this.pageStack.size())
    })
    .onWillDisappear(() => {
      console.debug('===NavDestination-onWillDisappear:' + this.pageStack.size())
    })
    .onDisAppear(() => {
      console.debug('===通用-onDisappear:' + this.pageStack.size())
    })
  }

  aboutToAppear(): void {
    this.navDestinationInfo = this.queryNavDestinationInfo()
    this.pathStackSize = this.pageStack.size()
    this.pageParam = this.pageStack.getParamByIndex(this.pathStackSize - 1) as string
    console.debug('===自定义组件-aboutToAppear:' + this.pageStack.size())
    observer.on('navDestinationUpdate', (info) => {
      console.info('===NavDestination state update', JSON.stringify(info));
    });
  }

  aboutToDisappear(): void {
    console.debug('===自定义组件-aboutToDisappear:' + this.pageStack.size())
  }
}