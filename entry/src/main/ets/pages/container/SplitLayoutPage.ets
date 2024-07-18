import { SplitLayout } from '@ohos.arkui.advanced.SplitLayout';

@Entry
@Component
struct SplitLayoutPage {
  @State layoutHeight: number = 400

  build() {
    Column() {
      SplitLayout({
        mainImage: $r('app.media.img1'),
        primaryText: '今日头条',
        secondaryText: '今天是一个晴朗凉快的的大夏天的啊啊啊啊啊啊',
        tertiaryText: '持续更新',
      }) {
        Text('这是在哪里显示的啊')
          .margin(20)
      }
    }.width('100%')
  }
}