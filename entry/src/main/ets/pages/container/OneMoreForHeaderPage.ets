@Entry
@Component
struct OneMoreForHeaderPage {
  @State needWarp: boolean = true

  build() {
    Column() {
      GridRow() {
        GridCol({
          span: { sm: 12, md: 6, lg: 7 }
        }) {
          Row() {
            Text('首页').fontColor(Color.Black).fontSize(16)
            Blank()
            Image($r('app.media.tab_home_t'))
              .width(30).height(30)
              .visibility(this.needWarp ? Visibility.Visible : Visibility.None)
          }.width('100%')
          .height(45)
          .alignItems(VerticalAlign.Center)
        }

        GridCol({ span: { sm: 12, md: 6, lg: 5 } }) {
          Flex({ direction: FlexDirection.Row, alignItems:ItemAlign.Center}) {
            Search({ placeholder: '请输入你想搜索的内容' })
              .margin({ top: 4, bottom: 4 })
            Image($r('app.media.tab_info_t'))
              .width(30).height(30).objectFit(ImageFit.Contain).margin({ left: 10 })
            Image($r('app.media.tab_home_t'))
              .width(30)
              .height(30)
              .objectFit(ImageFit.Contain)
              .margin({ left: 10 })
              .visibility(this.needWarp ? Visibility.None : Visibility.Visible)
          }
        }
      }
      .onBreakpointChange((breakpoint: string) => {
        if (breakpoint === 'sm') {
          this.needWarp = true
        } else {
          this.needWarp = false
        }
      })
      .padding({ left: 15, right: 15 })
    }.width('100%')
  }
}