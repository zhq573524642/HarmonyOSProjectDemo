import { CommonButton, CommonTitle } from '../component/MyComponent'
import { NetTestBean } from './NetTestBean'
import mViewModel from './NetworkViewModel'
import { promptAction, router } from '@kit.ArkUI'
import { AxiosError } from '@ohos/axios'

@Entry
@Component
struct NetworkTestPage {
  build() {
    Column() {
      CommonTitle({title:'Network Kit数据传输能力'})
      CommonButton({text:'HTTP数据请求'})
        .onClick(()=>{
           router.pushUrl({
              url:'pages/network/HttpTestPage'
           })
        })
      CommonButton({text:'WebSocket连接'})
      CommonButton({text:'Socket连接'})
      CommonButton({text:'MDNS管理'})
      CommonTitle({title:'Network Kit网络管理能力'})
      CommonTitle({ title: '网络请求axios' })
      CommonButton({ text: 'Get请求' })
        .onClick(() => {
          this.handleGetRequest()
        })
    }.width('100%')
  }

  handleGetRequest() {
    mViewModel.handleGetRequest()
      .then((data: string) => {
        promptAction.showToast({ message: `结果：${data}` })
      })
      .catch((error: AxiosError) => {
        console.debug(`===异常${error.code}-${error.message}`)
      })
  }
}