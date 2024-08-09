import { DefaultStateEnum } from './DefaultStateEnum';

@Component
export struct DefaultStatePage {
  @BuilderParam normalPage: () => void;
  @Prop defaultState: number = DefaultStateEnum.LOADING
  @Prop noDataMsg: string
  @Prop errorMsg: string
  icon?: ResourceStr = $r('app.media.common_no_data_icon')

  build() {
    Column() {
      if (this.defaultState === DefaultStateEnum.LOADING) {
        this.loading()
      } else if (this.defaultState === DefaultStateEnum.EMPTY) {
        this.empty()
      } else if (this.defaultState === DefaultStateEnum.ERROR) {
        this.error()
      } else {
        this.normalPage()
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  loading() {
    Column() {
      LoadingProgress()
        .color($r('app.color.theme_color'))
        .height(100)
        .width(100)
        .backgroundColor(Color.Transparent)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }

  @Builder
  empty() {
    Column() {
      Image(this.icon)
        .width(80)
        .height(80)
      Text(this.noDataMsg ? this.noDataMsg : '没有数据').margin({ top: 15 })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }

  @Builder
  error() {
    Column() {
      Image(this.icon)
        .width(80)
        .height(80)
      Text(this.errorMsg ? this.errorMsg : '数据错误').margin({ top: 15 })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}