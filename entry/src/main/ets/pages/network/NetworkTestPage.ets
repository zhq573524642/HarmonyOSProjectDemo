import { CommonButton, CommonTitle } from '../component/MyComponent'
import { NetTestBean } from './NetTestBean'
import mViewModel from './NetworkViewModel'
import { promptAction } from '@kit.ArkUI'
import { AxiosError } from '@ohos/axios'

@Entry
@Component
struct NetworkTestPage {
  build() {
    Column() {
      CommonTitle({ title: '网络请求' })
      CommonButton({ text: 'Get请求' })
        .onClick(() => {
          this.handleGetRequest()
        })
    }.width('100%')
  }

  handleGetRequest() {
    mViewModel.handleGetRequest()
      .then((data: NetTestBean) => {
        promptAction.showToast({ message: `结果：${data?.time}` })
      })
      .catch((error: AxiosError) => {
        console.debug(`===异常${error.code}-${error.message}`)
      })
  }
}