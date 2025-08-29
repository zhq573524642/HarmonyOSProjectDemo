import {
  DefaultStateEnum,
  DefaultStatePage,
  FooterLoadMoreStatus,
  HeaderRefreshStatus,
  SVRefresh,
  ToastUtils
} from '@ohos/common';
import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct RefreshStatePage {
  // 用来控制刷新状态
  @State private refreshStatus: HeaderRefreshStatus = HeaderRefreshStatus.inactive
  // 用来控制加载状态
  @State private loadMoreStatus: FooterLoadMoreStatus = FooterLoadMoreStatus.inactive
  @State pageState: DefaultStateEnum = DefaultStateEnum.LOADING
  @State msgNoData: string = '暂无数据啊~'
  @State msgError: string = '数据异常，点击重试'
  @State isEnableStatePagePull: boolean = true

  build() {
    Column() {
      Flex({
        wrap: FlexWrap.Wrap,
        direction: FlexDirection.Row,
        space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) }
      }) {
        Button('加载中')
          .onClick(() => {
            this.pageState = DefaultStateEnum.LOADING
          })
        Button('显示数据')
          .onClick(() => {
            this.pageState = DefaultStateEnum.NORMAL
          })
        Button('无数据')
          .onClick(() => {
            this.pageState = DefaultStateEnum.EMPTY
          })
        Button('异常')
          .onClick(() => {
            this.pageState = DefaultStateEnum.ERROR
          })
        Button(`是否空数据/异常布局可下拉：${this.isEnableStatePagePull ? '可以' : '不可以'}`)
          .onClick(() => {
            this.isEnableStatePagePull = !this.isEnableStatePagePull
          })
      }
      .margin({ left: 10, right: 10 })

      this.RefreshView()
    }.width('100%')
  }

  @Builder
  RefreshView() {
    SVRefresh({
      refreshStatus: this.refreshStatus,
      loadMoreStatus: this.loadMoreStatus,
      refreshOptions: {},
      childList: (scroller) => {
        this.ContentView(scroller)
      },
      onRefreshing: () => {
        setTimeout(() => {
          this.refreshStatus = HeaderRefreshStatus.inactive
        }, 3000)
      },
      onLoadingMore: () => {
        setTimeout(() => {
          this.loadMoreStatus = FooterLoadMoreStatus.inactive
        }, 3000)
      }
    })
      .layoutWeight(1)
  }

  @Builder
  ContentView(scroller: Scroller) {
    DefaultStatePage({
      isEnablePull: this.isEnableStatePagePull,
      scroller: scroller,
      defaultState: this.pageState,
      noDataMsg: this.msgNoData,
      errorMsg: this.msgError,
      normalPage: () => {
        this.ListView(scroller)
      },
      onRetryCallback: () => {
        ToastUtils.show('重试')
      }
    })
  }

  @Builder
  ListView(_scroller: Scroller) {
    Scroll(_scroller) {
      Column() {
        Column() {

        }.height(500)
        .width('100%')
        .backgroundColor(Color.Red)

        Column() {

        }.height(500)
        .width('100%')
        .backgroundColor(Color.Green)
      }.width('100%')
      .layoutWeight(1)
    }.scrollBar(BarState.Off)
  }
}