import router from '@ohos.router'
import { CommonButton } from '../component/MyComponent'

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
              router.pushUrl({ url: 'pages/container/ScrollPage',
                params: {
                  direction: 1
                } }, router.RouterMode.Single)
            })
            .layoutWeight(1)
            .height(40)

          CommonButton({ text: 'Scroll组件-水平' })
            .onClick(() => {
              router.pushUrl({ url: 'pages/container/ScrollPage',
                params: {
                  direction: 2
                } }, router.RouterMode.Single)
            })
            .layoutWeight(1)
            .height(40)
        }.width('100%')

        CommonButton({ text: '相对布局-RelativeContainer' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/container/RelativeContainerPage' })
          })

        CommonButton({ text: '列表布局-List' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/list/ListPage' })
          })
        CommonButton({ text: '列表布局操作' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/list/ListHandlePage' })
          })
        CommonButton({text:'网格布局Grid'})
          .onClick(()=>{
            router.pushUrl({url:'pages/container/GridPage'})
          })
        CommonButton({text:'轮播Swiper'})
          .onClick(()=>{
            router.pushUrl({url:'pages/container/SwiperPage'})
          })
        CommonButton({text:'瀑布流WaterFlow'})
          .onClick(()=>{
            router.pushUrl({url:'pages/container/WaterFlowPage'})
          })
        CommonButton({text:'可滑动面板Panel'})
          .onClick(()=>{
            router.pushUrl({url:'pages/container/PanelPage'})
          })
        CommonButton({text:'下拉刷新Refresh'})
          .onClick(()=>{
            router.pushUrl({url:'pages/container/RefreshPage'})
          })
        CommonButton({text:'侧边栏SideBarContainer'})
          .onClick(()=>{
            router.pushUrl({url:'pages/container/SideBarContainerPage'})
          })


      }.width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .scrollable(ScrollDirection.Vertical)
    .width('100%')
    .height('100%')
  }
}