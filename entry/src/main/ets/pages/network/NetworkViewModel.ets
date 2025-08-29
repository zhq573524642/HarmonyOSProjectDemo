import { AxiosError } from '@ohos/axios'
import { httpARequestGet } from '@ohos/common'
import { ResponseResultC } from './ResponseResult'
import { NetTestBean } from './NetTestBean'

const HOST_URL: string = "https://www.wanandroid.com"

class NetworkViewModel {
  //get请求与
  handleGetRequest(): Promise<string> {
    return new Promise(async (resolve, reject) => {
      //参数
      let param: Record<string, Object> = {
        "formatType": 1
      }
      httpARequestGet<string>('/project/tree/json', param, HOST_URL)
        .then((data: string) => {
          if (data) {
            resolve(data)
          }else {
            reject('请求错误')
          }
        })
        .catch((error: AxiosError) => {
          reject(error)
        })
    })
  }
}

let mViewModel: NetworkViewModel = new NetworkViewModel()

export default mViewModel as NetworkViewModel