import { WindowUtil } from '@ohos/common'
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct ImmersionPage {
  private context = getContext(this) as common.UIAbilityContext
  @State navigationHeight: number | undefined = 0
  @State statusBarHeight: number | undefined = 0
  @State isStatusBarEnable: boolean = true

  build() {
    Row() {
      Column({ space: 10 }) {
        Stack({alignContent:Alignment.Center}){
          Text('沉浸式').fontColor(Color.Red).fontSize(16)
        }.width('100%')
        .backgroundColor(Color.Pink)
        .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP])
        Image($r('app.media.img1')).width('100%').height(300)
          .objectFit(ImageFit.Cover)
        Button('设置全屏显示')
          .onClick(() => {
            WindowUtil.getIsFullScreen(this.context)
              .then((isFullScreen: boolean) => {
                if (!isFullScreen) {
                  WindowUtil.setWindowLayoutFullScreen(this.context, true)
                }
              })

          })
        Button('设置取消全屏显示')
          .onClick(() => {
            WindowUtil.getIsFullScreen(this.context)
              .then((isFullScreen: boolean) => {
                if (isFullScreen) {
                  WindowUtil.setWindowLayoutFullScreen(this.context, false)
                }
              })
          })
        Button('设置避让导航栏')
          .onClick(() => {
            this.navigationHeight = AppStorage.get<number>('naviIndicatorHeight')
          })
        Button('设置避让状态栏')
          .onClick(() => {
            this.statusBarHeight = AppStorage.get<number>('statusBarHeight')
          })
        Button('设置状态栏是否可用')
          .onClick(() => {
            this.isStatusBarEnable = !this.isStatusBarEnable
            WindowUtil.updateStatusBarEnable(this.context, this.isStatusBarEnable)
          })
        Button('设置状态栏样式')
          .onClick(() => {
            WindowUtil.updateStatusBarColor(this.context, '#ff0000', '#00ff00')
          })
      }.width('100%')
      .height('100%')
      .margin({
        bottom: this.navigationHeight ? this.navigationHeight : 0,
        top: this.statusBarHeight ? this.statusBarHeight : 0
      })
    }
  }
}