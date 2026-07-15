import router from '@ohos.router'
import { RouterUtil } from '@ohos/common'
import { CommonButton, CommonTitle } from '../component/MyComponent'
import { ListLearnPage } from '../list/ListLearnPage'
import { ColumnPage } from './ColumnPage'
import { FlexPage } from './FlexPage'
import { OneMoreMatchPage } from './OneMoreMatchPage'
import { RelativeContainerPage } from './RelativeContainerPage'
import { RowPage } from './RowPage'
import { ScrollPage } from './ScrollPage'
import { StackPage } from './StackPage'
import { TabsStickPage } from './TabsStickPage'

@Entry({
  routeName: 'ContainerComponentPage'
})
@Component
export struct ContainerComponentPage {
  private scroller: Scroller = new Scroller()

  static startPage() {
    RouterUtil.pushNamedRoute('ContainerComponentPage')
  }

  build() {
    Scroll(this.scroller) {
      Column() {

        CommonButton({ text: 'Column' })
          .onClick(() => {
            ColumnPage.startPage()
          })
        CommonButton({ text: 'Row' })
          .onClick(() => {
            RowPage.startPage()
          })
        CommonButton({ text: '层叠布局-Stack' })
          .onClick(() => {
            StackPage.startPage()
          })
        CommonButton({ text: '弹性布局Flex' })
          .onClick(() => {
            FlexPage.startPage()
          })
        Row() {
          CommonButton({ text: 'Scroll组件-垂直' })
            .onClick(() => {
              ScrollPage.startPage(1)
            })
            .layoutWeight(1)
            .height(40)

          CommonButton({ text: 'Scroll组件-水平' })
            .onClick(() => {
              ScrollPage.startPage(2)
            })
            .layoutWeight(1)
            .height(40)
        }.width('100%')


        CommonButton({ text: '相对布局-RelativeContainer' })
          .onClick(() => {
            RelativeContainerPage.startPage()
          })
        CommonButton({ text: '各种列表布局-List' })
          .onClick(() => {
            ListLearnPage.startPage()
          })
        CommonButton({ text: '一多适配' })
          .onClick(() => {
            OneMoreMatchPage.startPage()
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
        CommonButton({ text: '状态布局和下拉刷新上拉加载' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/container/RefreshStatePage'
            })
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
        CommonButton({ text: 'Tabs吸顶' })
          .onClick(() => {
            TabsStickPage.start()
          })

      }.width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .scrollable(ScrollDirection.Vertical)
    .width('100%')
    .height('100%')
  }
}