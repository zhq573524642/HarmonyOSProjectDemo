import { BreakpointSystem, BreakPointType, BreakpointTypeEnum } from '@ohos/common'

interface TabBar {
  name: string
  icon: Resource
  selectIcon: Resource
}

@Entry
@Component
struct OneMoreForHomeTabPage {
  @State currentIndex: number = 0
  @State tabs: Array<TabBar> = [{
    name: '首页',
    icon: $r('app.media.tab_home_f'),
    selectIcon: $r('app.media.tab_home_t')
  }, {
    name: '排行榜',
    icon: $r('app.media.tab_info_f'),
    selectIcon: $r('app.media.tab_info_t')
  }, {
    name: '我的',
    icon: $r('app.media.tab_my_f'),
    selectIcon: $r('app.media.tab_my_t')
  }]

  @Builder
  TabBarBuilder(index: number, tabBar: TabBar) {
    Flex({
      direction: new BreakPointType({
        sm: FlexDirection.Column,
        md: FlexDirection.Row,
        lg: FlexDirection.Column
      }).getValue(this.currentBreakpoint),
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
    }) {
      Image(this.currentIndex === index ? tabBar.selectIcon : tabBar.icon)
        .size({ width: 36, height: 36 })
        .objectFit(ImageFit.Contain)
      Text(tabBar.name)
        .fontColor(this.currentIndex === index ? Color.Blue : '#999999')
        .margin(new BreakPointType<(Length | Padding)>({
          sm: { top: 4 },
          md: { left: 8 },
          lg: { top: 4 }
        }).getValue(this.currentBreakpoint)!)
        .fontSize(16)
    }
    .width('100%')
    .height('100%')
  }

  @StorageLink('currentBreakpoint') currentBreakpoint: string = 'md'
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()

  aboutToAppear() {
    this.breakpointSystem.register()
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister()
  }

  build() {
    Tabs({
      barPosition: new BreakPointType({
        sm: BarPosition.End,
        md: BarPosition.End,
        lg: BarPosition.Start
      }).getValue(this.currentBreakpoint)
    }) {
      ForEach(this.tabs, (item: TabBar, index) => {
        TabContent() {
          Stack() {
            Column() {
              Text(item.name + ':' + this.currentBreakpoint).fontSize(30)
              Button('点击切换屏幕大小')
                .onClick(() => {
                  if (this.currentBreakpoint === BreakpointTypeEnum.SM) {
                    this.currentBreakpoint = BreakpointTypeEnum.MD
                  } else if (this.currentBreakpoint === BreakpointTypeEnum.MD) {
                    this.currentBreakpoint = BreakpointTypeEnum.LG
                  } else {
                    this.currentBreakpoint = BreakpointTypeEnum.SM
                  }
                })
            }
          }.width('100%').height('100%')
        }.tabBar(this.TabBarBuilder(index!, item))
      })
    }
    .vertical(new BreakPointType({ sm: false, md: false, lg: true }).getValue(this.currentBreakpoint)!)
    .barWidth(new BreakPointType({ sm: '100%', md: '100%', lg: '60vp' }).getValue(this.currentBreakpoint)!)
    .barHeight(new BreakPointType({ sm: '76vp', md: '56vp', lg: '60%' }).getValue(this.currentBreakpoint)!)
    .animationDuration(0)
    .divider({
      strokeWidth: 1,
      color: Color.Gray
    })
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}