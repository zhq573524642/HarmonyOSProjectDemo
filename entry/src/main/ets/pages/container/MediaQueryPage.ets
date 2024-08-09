import { mediaquery, window } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct MediaQueryPage {
  listener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync('(orientation: landscape)')
  @State textStr: string = ''
  @State textColor: ResourceColor = Color.Orange
  @State isLandscape: boolean = false

  onPortrait(mediaQueryResult: mediaquery.MediaQueryResult) {
    if (mediaQueryResult.matches as boolean) {
      //如果是横屏
      this.textStr = '横屏'
      this.textColor = Color.Red
    } else {
      this.textStr = '竖屏'
      this.textColor = Color.Orange
    }
  }

  aboutToAppear(): void {
    this.listener.on("change", (mediaQueryResult: mediaquery.MediaQueryResult) => {
      this.onPortrait(mediaQueryResult)
    })
  }

  aboutToDisappear(): void {
    this.listener.off("change")
  }

  // 改变设备横竖屏状态函数
  private changeOrientation(isLandscape: boolean) {
    // 获取UIAbility实例的上下文信息
    let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
    // 调用该接口手动改变设备横竖屏状态
    window.getLastWindow(context).then((lastWindow) => {
      lastWindow.setPreferredOrientation(isLandscape ? window.Orientation.LANDSCAPE : window.Orientation.PORTRAIT)
    });
  }

  build() {
    Column({ space: 10 }) {
      Text(this.textStr).fontSize(20).fontColor(this.textColor)
      Button('切换横竖屏')
        .onClick(() => {
          this.isLandscape = !this.isLandscape
          this.changeOrientation(this.isLandscape)
        })
    }.width('100%')
    .margin({ top: 20 })
  }
}