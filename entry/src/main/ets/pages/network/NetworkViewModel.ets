import { AxiosError } from '@ohos/axios'
import { httpARequestGet } from '@ohos/common'
import { ResponseResultC } from './ResponseResult'
import { NetTestBean } from './NetTestBean'

const HOST_URL: string = "https://www.wanandroid.com"

class NetworkViewModel {
  //get请求与
  handleGetRequest(): Promise<NetTestBean> {
    return new Promise(async (resolve, reject) => {
      //参数
      let param: Record<string, Object> = {
        "formatType": 1
      }
      httpARequestGet<ResponseResultC<NetTestBean>>('/v1/servers/time', param, HOST_URL)
        .then((data: ResponseResultC<NetTestBean>) => {
          if (data.code == 0) {
            resolve(data.data)
          }else {
            reject(data.msg)
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