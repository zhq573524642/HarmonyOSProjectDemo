import { HarLibRouterName } from './HarLibRouterName';
import { router } from '@kit.ArkUI';

@Entry({ routeName: HarLibRouterName.PATH_HAR_MAIN_PAGE })
@Component
export struct HarMainPage {
  message: string = 'HAR静态共享包的页面组件';
  @State paramName: string = ''

  static startPage(param: string) {
    router.pushNamedRoute({
      name: HarLibRouterName.PATH_HAR_MAIN_PAGE,
      params: {
        param_name: param
      }
    })
  }

  aboutToAppear(): void {
    const param = router.getParams() as Record<string, Object>
    if (param) {
      this.paramName = param.param_name as string
    }
  }

  build() {
    Row() {
      Column() {
        Text(`${this.message}-参数：${this.paramName}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Button('返回HAP页面')
          .onClick(() => {
            router.back({
              url: 'pages/ui/arkts/HarLibPage'
            })
          })
          .margin(20)

      }
      .width('100%')
    }
    .height('100%')
  }
}
