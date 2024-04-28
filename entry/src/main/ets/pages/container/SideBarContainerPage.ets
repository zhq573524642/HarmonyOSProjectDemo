import { CommonButton } from '../component/MyComponent'

@Entry
@Component
struct SideBarContainerPage {
  @State isShowSideBar: boolean = false

  build() {

    SideBarContainer(SideBarContainerType.Overlay) {
      //侧边栏区
      Column() {
        Text('Item1').fontColor(Color.Blue).fontSize(13).margin(3)
        Text('Item2').fontColor(Color.Blue).fontSize(13).margin(3)
        Text('Item3').fontColor(Color.Blue).fontSize(13).margin(3)
        Text('Item4').fontColor(Color.Blue).fontSize(13).margin(3)
      }
      .width('240vp')
      .backgroundColor(Color.Pink)
      .borderColor(Color.Red)
      .borderWidth(2)
      .borderRadius(10)
      .margin(10)
      .borderStyle(BorderStyle.Solid)
      .height('100vp')
      //内容区
      Column() {
        CommonButton({ text: '点击' })
          .onClick(() => {
            this.isShowSideBar = !this.isShowSideBar
          })
        Text('内容')
          .fontColor(Color.Red)
          .fontSize(30)
          .width('100%')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }.width('100%')
      .height('100%')

    }
    .showSideBar(this.isShowSideBar) //是否显示SideBarContainer
    .showControlButton(true) //是否显示控制sideBar按钮
    .controlButton({ //控制sideBar按钮样式
      left: 10,
      top: 10,
      width: 25,
      height: 25,
      icons: {
        shown: $r('app.media.tab_info_t'),
        hidden: $r('app.media.tab_info_f'),
        switching: $r('app.media.icon_menu')
      }
    })
    .sideBarWidth(240) //侧边栏宽度
    .minSideBarWidth(200) //侧边栏最小宽度
    .maxSideBarWidth(280) //侧边栏最大宽度
    .autoHide(true) //设置当侧边栏拖拽到小于最小宽度后，是否自动隐藏。默认值：true
    .sideBarPosition(SideBarPosition.Start) //侧边栏位置 Start左侧 End右侧
    .onChange((isShown: boolean) => {
      this.isShowSideBar = isShown
    })
  }
}