import { PageRouter } from "../../router/PageRouter";
import { AlertDialog, ConfirmDialog, CustomContentDialog, router } from "@kit.ArkUI";
import { webview } from "@kit.ArkWeb";
import { ToastUtils } from "@ohos/common";

@Entry({ routeName: PageRouter.PAGE_WEB_SHOW_WINDOW })
@Component
export struct WebShowWindowPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_SHOW_WINDOW
    }, router.RouterMode.Single)
  }

  uiContext: UIContext = this.getUIContext()
  webController: webview.WebviewController = new webview.WebviewController()
  @State title: string = ''
  @State subTitle: string = ''
  @State message: string = ''
  @State eventResult: JsResult | null = null
  @State isShowWebAlert: boolean = true
  @State isCheck: boolean = false
  webAlertWindowDialogController: CustomDialogController = new CustomDialogController({
    builder: AlertDialog({
      primaryTitle: this.title,
      secondaryTitle: this.subTitle,
      content: this.message,
      primaryButton: {
        value: '确定',
        background: Color.Yellow,
        fontColor: Color.Black,
        action: () => {
          this.eventResult?.handleConfirm()
        }
      }
    }),
    onWillDismiss: () => {
      this.eventResult?.handleCancel()
      this.webAlertWindowDialogController.close()
    }
  })
  webConfirmWindowDialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      title: this.title,
      content: this.message,
      isChecked: this.isCheck,
      checkTips: '阅读同意饼勾选',
      primaryButton: {
        value: '同意',
        action: () => {
          if (!this.isCheck) {
            ToastUtils.show('请先阅读并勾选')
            return
          }
          this.eventResult?.handleConfirm()

        }
      },
      secondaryButton: {
        value: '不同意',
        action: () => {
          this.eventResult?.handleCancel()
        }
      },
      onCheckedChange: (checked) => {
        this.isCheck = checked
      }
    }),
    onWillDismiss: () => {
      this.eventResult?.handleCancel()
      this.webConfirmWindowDialogController.close()
    },
    autoCancel: true
  })
  webPromptWindowDialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: this.title,
      contentBuilder: () => {
        this.buildContent()
      },
      buttons: [
        {
          value: '确定',
          action: () => {
            this.eventResult?.handlePromptConfirm(this.promptResult)
          }
        },
        {
          value: '取消',
          action: () => {
            this.eventResult?.handleCancel()
          }
        }
      ]
    }),
    onWillDismiss: () => {
      this.eventResult?.handleCancel()
      this.webPromptWindowDialogController.close()
    }
  })
  @State promptResult: string = ''

  @Builder
  buildContent() {
    Column() {
      Text(this.message).fontSize(16).fontColor(Color.Red)
      TextInput({
        text: $$this.promptResult,
        placeholder: '请输入验证码',
      })
    }
  }

  build() {
    Column({ space: 10 }) {
      Web({ src: $rawfile('H5ShowWindow.html'), controller: this.webController })
        .onAlert((event) => {
          if (event) {
            if (this.isShowWebAlert) {
              this.uiContext.showAlertDialog({
                title: `来自 ${event.url} 的Alert`,
                message: event.message,
                confirm: {
                  enabled: true,
                  value: '确定',
                  backgroundColor: Color.Green,
                  fontColor: Color.White,
                  action: () => {
                    event.result.handleConfirm()
                  }
                },
                cancel: () => {
                  event.result.handleCancel()
                }
              })
            } else {
              this.title = `来自 ${event.url} 的Alert`
              this.subTitle = '温馨提示'
              this.message = event.message
              this.eventResult = event.result
              this.webAlertWindowDialogController.open()
            }
          }

          return true
        })
        .onConfirm((event) => {
          if (event) {
            if (this.isShowWebAlert) {
              this.uiContext.showAlertDialog({
                title: `来自${event.url}的confirm`,
                subtitle: '温馨提示啊',
                message: event.message,
                primaryButton: {
                  value: 'OK',
                  action: () => {
                    event.result.handleConfirm()
                  }
                },
                secondaryButton: {
                  value: 'Cancel',
                  action: () => {
                    event.result.handleCancel()
                  }
                },
                cancel: () => {
                  event.result.handleCancel()
                }
              })
            } else {
              this.title = `来自${event.url}的confirm`
              this.message = event.message
              this.eventResult = event.result
              this.webConfirmWindowDialogController.open()
            }
          }
          return true
        })
        .onPrompt((event) => {
          if (event) {
            this.title = `来自${event.url}的prompt`
            this.message = event.message
            this.promptResult = event.value
            this.eventResult = event.result
            this.webPromptWindowDialogController.open()
          }
          return true
        })
        .width('100%')
        .layoutWeight(1)

      Button('使用UIContext的showAlertDialog')
        .onClick(() => {
          this.isShowWebAlert = true
        })
      Button('使用CustomDialogController')
        .onClick(() => {
          this.isShowWebAlert = false
        })

    }
  }
}