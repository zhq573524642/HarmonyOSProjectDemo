import { router } from '@kit.ArkUI';
import { HspLibRouterName } from './HspLibRouterName';


@Entry({ routeName: HspLibRouterName.PATH_HSP_LIB_PAGE })
@Component
export struct HspMainPage {
  isByNavigation: boolean = false
  message: string = '从Entry HAP包跳转过来的';
  @State paramName: string = ''
  pathStack: NavPathStack = new NavPathStack()

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
    NavDestination() {
      Row() {
        Column() {
          Text(`${this.message}${this.paramName}`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          if (!this.isByNavigation) {
            Button('Router返回')
              .onClick(() => {
                router.back({
                  url: 'pages/ui/arkts/HspLibPage'
                })
              })
          }

          if (this.isByNavigation) {
            Button('Navigation返回')
              .onClick(() => {
                this.pathStack.pop()
              })
          }

        }
        .width('100%')
      }
      .height('100%')
    }.title("HspMainPage")
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context?.pathStack
      let param = context?.pathInfo?.param as Record<string, Object>
      if (param) {
        this.paramName = param.param as string
      }
    })
  }
}

@Builder
export function HspMainPageBuilder() {
  HspMainPage({ message: '从Entry通过Navigation跳转：', isByNavigation: true })
}