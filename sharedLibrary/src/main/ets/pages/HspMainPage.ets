import { router } from '@kit.ArkUI';
import { HspLibRouterName } from './HspLibRouterName';

@Entry({ routeName: HspLibRouterName.PATH_HSP_LIB_PAGE })
@Component
export struct HspMainPage {
  message: string = '从Entry HAP包跳转过来的';
  @State paramName: string = ''

  static startPage(param: string) {
    router.pushNamedRoute({
      name: HspLibRouterName.PATH_HSP_LIB_PAGE,
      params: {
        param_name: param
      }
    })
  }

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, Object>
    if (params) {
      this.paramName = params.param_name as string
    }
  }

  build() {
    Row() {
      Column() {
        Text(`${this.message}-参数：${this.paramName}`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Button('返回')
          .onClick(() => {
            router.back({
              url: 'pages/ui/arkts/HspLibPage'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}