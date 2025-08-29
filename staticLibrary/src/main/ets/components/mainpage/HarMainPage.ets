import { HarLibRouterName } from './HarLibRouterName';
import { router } from '@kit.ArkUI';

@Entry({ routeName: HarLibRouterName.PATH_HAR_MAIN_PAGE })
@Component
export struct HarMainPage {
  message: string = '从Entry HAP包跳转过来的';
  @State paramName: string = ''
  navPathStack: NavPathStack = new NavPathStack()
  isByNavigation: boolean = false

  static startPage(param: string) {
    router.pushNamedRoute({
      name: HarLibRouterName.PATH_HAR_MAIN_PAGE,
      params: {
        param_name: param
      }
    }, router.RouterMode.Single)
  }

  aboutToAppear(): void {
    const param = router.getParams() as Record<string, Object>
    if (param) {
      this.paramName = param.param_name as string
    }
  }

  build() {
    NavDestination() {
      Row() {
        Column() {
          Text(`${this.message}：${this.paramName}`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          if (!this.isByNavigation) {
            Button('返回HAP页面')
              .onClick(() => {
                router.back({
                  url: 'pages/ui/arkts/HarLibPage'
                })
              })
              .margin(20)
          }

          if (this.isByNavigation) {
            Button('返回HAP页面')
              .onClick(() => {
                this.navPathStack.pop()
              })
          }


        }
        .width('100%')
      }
      .height('100%')
    }.width('100%')
    .height('100%')
    .title('Har页面')
    .onReady((context: NavDestinationContext) => {
      this.navPathStack = context?.pathStack
      let param = context?.pathInfo?.param as Record<string, Object>
      if (param) {
        this.paramName = param.param as string
      }
    })
  }
}

@Builder
export function HarMainPageBuilder() {
  HarMainPage({ message: '从Entry通过Navigation跳转：', isByNavigation: true })
}
