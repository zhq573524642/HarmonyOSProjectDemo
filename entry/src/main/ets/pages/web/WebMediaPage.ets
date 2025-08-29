import { webview } from "@kit.ArkWeb"
import { abilityAccessCtrl } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { PageRouter } from "../../router/PageRouter";
import { router } from "@kit.ArkUI";

@Entry({ routeName: PageRouter.PAGE_WEB_MEDIA })
@Component
export struct WebMediaPage {
  webController: webview.WebviewController = new webview.WebviewController()
  uiContext = this.getUIContext()

  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_MEDIA
    }, router.RouterMode.Single)
  }

  aboutToAppear(): void {
    webview.WebviewController.setWebDebuggingAccess(true)

    // 获取权限请求通知，点击onConfirm按钮后，拉起摄像头和麦克风。
    let atManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(this.uiContext.getHostContext(),
      ['ohos.permission.CAMERA', 'ohos.permission.MICROPHONE'])
      .then((data) => {
        console.info('data:' + JSON.stringify(data));
        console.info('data permissions:' + data.permissions);
        console.info('data authResults:' + data.authResults);
      }).catch((error: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${error.code}, message is ${error.message}`);
    })
  }

  build() {
    Column() {
      Web({ src: $rawfile('H5Media.html'), controller: this.webController })
        .width('100%')
        .height('100%')
        .onPermissionRequest((event) => {
          if (event) {
            this.uiContext.showAlertDialog({
              title: 'title',
              message: 'text',
              primaryButton: {
                value: 'deny',
                action: () => {
                  event.request.deny();
                }
              },
              secondaryButton: {
                value: 'onConfirm',
                action: () => {
                  event.request.grant(event.request.getAccessibleResource());
                }
              },
              cancel: () => {
                event.request.deny();
              }
            })
          }
        })
    }.width('100%')
    .height('100%')
  }
}