import { RouterUtil } from '@ohos/common'

@Entry({ routeName: 'NetworkConnectionPage' })
@Component
export struct NetworkConnectionPage {
  static start() {
    RouterUtil.pushNamedRoute('NetworkConnectionPage')
  }

  build() {
    Column() {
      Text('NetworkConnectionPage')
    }
  }
}