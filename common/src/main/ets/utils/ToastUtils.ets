import { promptAction } from '@kit.ArkUI'

export class ToastUtils {

  static show(msg: string | Resource, duration?: number, alignment?: Alignment) {
    promptAction.showToast({
      message: msg,
      duration: duration,
      alignment: alignment
    })
  }
}