import { promptAction } from "@kit.ArkUI"
import { BusinessError } from "@kit.BasicServicesKit"

export class DialogUtils {
  static uiContext: UIContext
  static componentContent: ComponentContent<Object>
  static options: promptAction.BaseDialogOptions

  static setContext(uiContext: UIContext) {
    DialogUtils.uiContext = uiContext
  }

  static setContentNode(node: ComponentContent<Object>) {
    DialogUtils.componentContent = node
  }

  static setOptions(options: promptAction.BaseDialogOptions) {
    DialogUtils.options = options
  }

  static show() {
    if (DialogUtils.componentContent !== null &&
      DialogUtils.uiContext !== null) {
      DialogUtils.uiContext.getPromptAction()
        .openCustomDialog(DialogUtils.componentContent, DialogUtils.options)
        .then(() => {

        })
        .catch((e: BusinessError) => {
          console.error('===openCustomDialog失败：' + e.code + '--' + e.message)
        })
    }
  }

  static update(options: promptAction.BaseDialogOptions) {
    if (DialogUtils.componentContent !== null &&
      DialogUtils.uiContext !== null) {
      DialogUtils.uiContext.getPromptAction()
        .updateCustomDialog(DialogUtils.componentContent, options)
        .then(() => {

        })
        .catch((e: BusinessError) => {
          console.error('===updateCustomDialog：' + e.code + '--' + e.message)
        })
    }
  }

  static close() {
    if (DialogUtils.componentContent !== null &&
      DialogUtils.uiContext !== null) {
      DialogUtils.uiContext.getPromptAction()
        .closeCustomDialog(DialogUtils.componentContent)
        .then(() => {

        })
        .catch((e: BusinessError) => {
          console.error('===closeCustomDialog失败：' + e.code + '--' + e.message)
        })
    }
  }
}