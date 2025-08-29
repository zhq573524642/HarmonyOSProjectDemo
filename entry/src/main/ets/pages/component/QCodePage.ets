import { CommonButton } from './MyComponent'
import { scanBarcode, scanCore } from '@kit.ScanKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils';
import { router } from '@kit.ArkUI';
import { CustomScanPage, PermissionUtils, RouterUtil } from '@ohos/common';
import { common } from '@kit.AbilityKit';

@Entry({ routeName: 'QCodePage' })
@Component
export struct QCodePage {
  static startPage() {
    RouterUtil.pushNamedRoute('QCodePage')
  }

  context = getContext(this) as common.UIAbilityContext
  @State private inputContent: string = ''
  options: scanBarcode.ScanOptions = {
    scanTypes: [scanCore.ScanType.ALL], //码类型
    enableMultiMode: true, //是否开启多码识别
    enableAlbum: true
  };
  @State qcodeResultStr: string = ''

  onPageShow(): void {
    const params = this.getUIContext().getRouter().getParams() as Record<string, Object>
    if (params) {
      let result = params.ScanResult as scanBarcode.ScanResult
      ToastUtils.show(`获取扫描结果：${JSON.stringify(result)}`)
    }
  }

  build() {

    Column({ space: 15 }) {
      TextInput({ placeholder: '请输入' })
        .width('90%')
        .margin(10)
        .height(50)
        .type(InputType.Normal)
        .onChange((value: string) => {
          this.inputContent = value
        })

      QRCode(this.inputContent)
        .color(Color.Pink)
        .backgroundColor(Color.Yellow)
        .width(200)
        .height(200)
      Text(this.qcodeResultStr).fontColor(Color.Blue).fontSize(16)
      CommonButton({ text: '扫码（默认UI界面）' })
        .onClick(() => {
          this.startScanDefault()
        })

      CommonButton({ text: '扫码（自定义UI界面）' })
        .onClick(() => {
          PermissionUtils.getInstance()
            .reqPermissionFromUser(this.context, "ohos.permission.CAMERA", (result: boolean) => {
              if (result) {
                CustomScanPage.startPageForResult('QCodePage')
              } else {
                ToastUtils.show('未获取相机权限')
              }
            })
        })
    }
    .width('100%')
    .height('100%')
  }

  startScanDefault() {
    try {
      // 可调用getContext接口获取当前页面关联的UIAbilityContext
      scanBarcode.startScanForResult(getContext(this), this.options,
        (error: BusinessError, result: scanBarcode.ScanResult) => {
          if (error) {
            if (error.code == 1000500002) {
              ToastUtils.show('扫码取消')
            } else if (error.code == 1000500001) {
              ToastUtils.show('网络异常，扫码失败')
            } else {
              ToastUtils.show(`扫码失败：${error.message}`)
            }
            return;
          }
          // 解析码值结果跳转应用服务页
          if (result) {
            this.qcodeResultStr = JSON.stringify(result)
          }
        })
    } catch (error) {
      ToastUtils.show(`扫码错误catch：${error.message}`)
    }
  }
}