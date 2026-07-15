import { BlockPuzzleModel, BlockPuzzleResponseModel } from './BlockPuzzleModel';
import { BusinessError } from '@kit.BasicServicesKit';
import { BaseViewModel } from './BaseViewModel';
import { httpBodyRequestPost } from './network/HttpUtil';
import { CryptoUtil } from './CryptoUtil';
import { API_CLOUD_URL, checkBlockPuzzle, getBlockPuzzle } from './network/Constants';

class BlockPuzzleViewModel extends BaseViewModel {
  /**
   * 获取验证图片
   */
  // 获取验证图片  host.API_CLOUD_URL +


  getPuzzleImage(): Promise<BlockPuzzleModel> {
    return new Promise<BlockPuzzleModel>((resolve, reject) => {
      this.showLoading()
      let params: Record<string, string> = {
        "captchaType": "blockPuzzle", //验证码类型
      }
      httpBodyRequestPost<BlockPuzzleResponseModel>(getBlockPuzzle, params, API_CLOUD_URL)
        .then((responseResult) => {
          this.hideLoading()
          if (responseResult.repCode == '0000') {
            resolve(responseResult.repData)
          } else {
            reject(responseResult.repMsg)
          }
        })
        .catch((error: BusinessError) => {
          this.hideLoading()
          console.log('123123123---' + error.message)
          reject(error.message)
        })
    })
  }

  /**
   * 校验滑动
   */
  checkPuzzle(pointX: number, puzzleModel: BlockPuzzleModel): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      let point: Record<string, number> = {
        'x': pointX,
        'y': 5
      }
      CryptoUtil.encodeCrypto(JSON.stringify(point), puzzleModel.secretKey)
        .then((pointEncodeJson) => {
          let params: Record<string, string> = {
            "pointJson": pointEncodeJson, //加密后的坐标
            "captchaType": "blockPuzzle", //验证码类型
            "token": puzzleModel.token, //获取验证码得到的token
            "distinguishSignatureVerificationMethod": "ios"
          }
          this.showLoading()
          httpBodyRequestPost<BlockPuzzleResponseModel>(checkBlockPuzzle, params, API_CLOUD_URL)
            .then((response) => {
              this.hideLoading()
              console.log('123123123---' + JSON.stringify(response))
              if (response.repCode == '0000') {
                // 返回验证字符串
                let verify = `${response.repData.token}---${JSON.stringify(point)}`
                CryptoUtil.encodeCrypto(verify, puzzleModel.secretKey)
                  .then((verifyEncode: string) => {
                    resolve(verifyEncode)
                  })
              } else {
                reject(response.repMsg)
              }
            })
            .catch((error: BusinessError) => {
              this.hideLoading()
              console.log('123123123---' + error.message)
              reject(error.message)
            })
        }).catch((error: string) => {
        console.log('123123123---' + error)
        reject(error)
      })
    })
  }
}

let blockPuzzleViewModel = new BlockPuzzleViewModel()

export default blockPuzzleViewModel