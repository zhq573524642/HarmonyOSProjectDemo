@Entry
@Component
struct RefreshPage {
  @State isRefreshing: boolean = false
  @State refreshContent: string = '刷新初始'

  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing, friction: 62, offset: '30vp' }) {
        Column() {
          Text('布局:' + this.refreshContent).fontSize(30).fontColor(Color.Orange)
        }.height('100%')
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }.onStateChange((state: RefreshStatus) => {
        switch (state) {
          case RefreshStatus.Drag:
            this.refreshContent = 'Drag：下拉中，下拉距离小于刷新距离。'
            break
          case RefreshStatus.OverDrag:
            this.refreshContent = 'OverDrag：下拉中，下拉距离超过刷新距离。'
            break
          case RefreshStatus.Refresh:
            this.refreshContent = 'Refresh：下拉结束，回弹至刷新距离，进入刷新状态。'
            break
          case RefreshStatus.Done:
            this.refreshContent = 'Done：刷新结束，返回初始状态（顶部）。'
            break
        }
      })
      .onRefreshing(() => {
        setTimeout(() => {
          this.isRefreshing = false
        }, 3000)
      })
    }.width('100%')
  }
}