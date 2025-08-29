import { PreferenceManager, RouterUtil, ToastUtils } from '@ohos/common'
import { CommonButton } from '../component/MyComponent'

@Entry({ routeName: 'PreferencePage' })
@Component
export struct PreferencePage {
  static startPage() {
    RouterUtil.pushNamedRoute('PreferencePage')
  }

  aboutToAppear(): void {
    PreferenceManager.getInstance().onChangedRegister()
  }

  aboutToDisappear(): void {
    PreferenceManager.getInstance().onChangedUnregister()
  }

  build() {
    Column() {
      CommonButton({ text: '保存' })
        .onClick(() => {
          PreferenceManager.getInstance().setValue<string>('name', '123456')
        })
      CommonButton({ text: '读取' })
        .onClick(async () => {
          let name = await PreferenceManager.getInstance().getValue<string>('name') as string
          ToastUtils.show(name)
        })
    }.width('100%')
    .height('100%')
  }
}