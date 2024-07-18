import router from '@ohos.router'
import { CommonButton, CommonTitle } from '../component/MyComponent'

@Entry
@Component
struct ContainerComponentPage {
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {

        CommonButton({ text: 'Column' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/ColumnPage' })
          })
        CommonButton({ text: 'Row' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/RowPage' })
          })
        CommonButton({ text: '层叠布局-Stack' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/StackPage' })
          })
        CommonButton({ text: '弹性布局Flex' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/FlexPage' })
          })
        Row() {
          CommonButton({ text: 'Scroll组件-垂直' })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/container/ScrollPage',
                params: {
                  direction: 1
                }
              }, router.RouterMode.Single)
            })
            .layoutWeight(1)
            .height(40)

          CommonButton({ text: 'Scroll组件-水平' })
            .onClick(() => {
              router.pushUrl({
                url: 'pages/container/ScrollPage',
                params: {
                  direction: 2
                }
              }, router.RouterMode.Single)
            })
            .layoutWeight(1)
            .height(40)
        }.width('100%')

        CommonButton({ text: '相对布局-RelativeContainer' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/RelativeContainerPage' })
          })
        CommonButton({ text: '各种列表布局-List' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/list/ListLearnPage' })
          })
        CommonButton({ text: '网格布局Grid' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/GridPage' })
          })
        CommonButton({ text: '轮播Swiper' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/SwiperPage' })
          })
        CommonButton({ text: '瀑布流WaterFlow' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/water_flow/WaterFlowPage' })
          })
        CommonButton({ text: '可滑动面板Panel' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/PanelPage' })
          })
        CommonButton({ text: '下拉刷新Refresh' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/RefreshPage' })
          })
        CommonButton({ text: '侧边栏SideBarContainer' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/SideBarContainerPage' })
          })
        CommonTitle({ title: '选项卡Tabs' })

        CommonButton({ text: '顶部Tabs' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/TabsPage',
              params: {
                tabType: 1
              }
            })
          })
        CommonButton({ text: '底部Tabs' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/TabsPage',
              params: {
                tabType: 2
              }
            })
          })
        CommonButton({ text: '自定义底部Tabs' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/TabsPage',
              params: {
                tabType: 3
              }
            })
          })
        CommonTitle({ title: '组合高级组件' })
        CommonButton({ text: 'SelectTitleBar（下拉菜单标题栏）' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/SelectTitleBarPage'
            })
          })
        CommonButton({ text: 'SplitLayout（上下结构布局）' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/SplitLayoutPage'
            })
          })
        CommonButton({ text: 'SubHeader（子标题）' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/SubHeaderPage'
            })
          })

        CommonButton({ text: 'TreeView（树视图）' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/TreeViewPage'
            })
          })

      }.width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .scrollable(ScrollDirection.Vertical)
    .width('100%')
    .height('100%')
  }
}