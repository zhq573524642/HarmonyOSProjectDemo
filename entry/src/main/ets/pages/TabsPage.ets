import router from '@ohos.router'
import { CommonButton } from './component/MyComponent'

@Entry
@Component
struct TabsPage {
  private tabType: object = router.getParams()
  private tabsTop: string[] = ['推荐', '直播', '电影', '电视剧', '综艺', '纪录片', '游戏', '动漫', '音乐', '体育']
  @State private tabPosition: BarPosition = BarPosition.Start
  @State private isTabVertical: boolean = false
  @State private currentIndex: number = 0
  private tabController: TabsController = new TabsController()

  build() {
    Column() {
      if (this.tabType?.['tabType'] == 1) {
        CommonButton({ text: '切换tabs位置' })
          .onClick(() => {
            if (this.tabPosition == BarPosition.Start && !this.isTabVertical) {
              this.tabPosition = BarPosition.End
              this.isTabVertical = false
            } else if (this.tabPosition == BarPosition.End && !this.isTabVertical) {
              this.tabPosition = BarPosition.Start
              this.isTabVertical = true
            } else if (this.tabPosition == BarPosition.Start && this.isTabVertical) {
              this.tabPosition = BarPosition.Start
              this.isTabVertical = false
            }
          })
        Tabs({ barPosition: this.tabPosition }) {
          ForEach(this.tabsTop, (subTab, index) => {
            TabContent() {
              Text(subTab)
                .fontSize(30)
                .fontColor(Color.Red)
            }.tabBar(subTab)
          }, index => index)
        }
        .scrollable(true) //页面是否可以滚动，默认可滚动
        .barPosition(this.tabPosition)
        .barMode(BarMode.Scrollable) //tabs的排列方式 BarMode.Scrollable可滚动、BarMode.Fixed填充（默认）
        .vertical(this.isTabVertical)
        .layoutWeight(1)
        .width('100%')
      } else if (this.tabType?.['tabType'] == 2) {
        Tabs({ barPosition: BarPosition.End }) {
          TabContent() {
            Text('首页')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Red)
          .tabBar('首页')

          TabContent() {
            Text('资讯')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Red)
          .tabBar('资讯')

          TabContent() {
            Text('发现')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Red)
          .tabBar('发现')

          TabContent() {
            Text('我的')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Red)
          .tabBar('我的')
        }
        .scrollable(true)
        .vertical(false)
        .barMode(BarMode.Fixed)
        .animationDuration(500) //页面切换动画的时间
        .onChange((index) => {
          console.info('====页面' + index)
        })
      }
      else {
        Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
          TabContent() {
            Text('首页')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Red)
          .tabBar(this.tabBuilder('首页', 0, $r('app.media.tab_home_t'), $r('app.media.tab_home_f')))

          TabContent() {
            Text('资讯')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Yellow)
          .tabBar(this.tabBuilder('资讯', 1, $r('app.media.tab_info_t'), $r('app.media.tab_info_f')))

          TabContent() {
            Text('发现')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Green)
          .tabBar(this.tabBuilder('发现', 2, $r('app.media.tab_find_t'), $r('app.media.tab_find_f')))

          TabContent() {
            Text('我的')
              .fontSize(30)
              .fontColor(Color.Black)
          }.backgroundColor(Color.Pink)
          .tabBar(this.tabBuilder('我的', 3, $r('app.media.tab_my_t'), $r('app.media.tab_my_f')))
        }
        .scrollable(true)
        .vertical(false)
        .barMode(BarMode.Fixed)
        .onChange((index) => {
          console.info('====页面' + index)
          this.currentIndex = index
        })
      }
    }.width('100%')
  }

  @Builder tabBuilder(tabTitle: string, targetIndex: number, selectIcon: ResourceStr, unselectIcon: ResourceStr) {
    Column() {
      Image(this.currentIndex == targetIndex ? selectIcon : unselectIcon)
        .width(25)
        .height(25)
      Text(tabTitle)
        .margin({ top: 8 })
        .fontSize(13)
        .fontColor(this.currentIndex == targetIndex ? $r('app.color.tab_select') : $r('app.color.tab_unselect'))
    }.width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex
      this.tabController.changeIndex(this.currentIndex)
    })
  }
}