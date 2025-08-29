import { http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit'

const HOST_URL: string = 'https://www.wanandroid.com'

// header接口
export interface HttpHeaderInterface {
  getHeader(): Record<string, Object>
}

const defaultHeader: Record<string, Object> = {
  'Content-Type': 'application/json',
}


const connectTimeout: number = 60000 //连接超时时间
const readTimeout: number = 60000 //读取超时时间

export function baseHttp<T>(httpRequest: http.HttpRequest, url: string, options: http.HttpRequestOptions): Promise<T> {
  return new Promise<T>(async (resolve: Function, reject: Function) => {
    httpRequest.request(
      HOST_URL + url,
      options, (err: BusinessError, data: http.HttpResponse) => {
      console.debug('===Request:\n' + 'Url:' + (HOST_URL + url) + '\n' + JSON.stringify(options))
      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        console.debug('===Response-Success:\n' +
          'Code:' + JSON.stringify(data?.responseCode) + '\n' +
          'Header:' + JSON.stringify(data?.header) + '\n' +
          'Cookies:' + JSON.stringify(data.cookies) + '\n' +
          'ResultData:' + JSON.stringify(data.result))
        if (data.responseCode === 200) {
          if (options.expectDataType == http.HttpDataType.OBJECT) {
            resolve(data?.result as T)
          } else if (options.expectDataType == http.HttpDataType.STRING) {
            const t: T = JSON.parse(data?.result?.toString())
            resolve(t)
          }
        } else {
          reject(data?.result?.toString())
        }

        // 当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy();
      } else {
        console.debug('===Response-Error:\n' + JSON.stringify(err))
        reject(JSON.stringify(err))
        // 取消订阅HTTP响应头事件
        httpRequest.off('headersReceive');
        // 当该请求使用完毕时，调用destroy方法主动销毁
        httpRequest.destroy();
      }
    }
    )
  })
}

/**
 *   header: {
 'Content-Type': 'application/json'
 }
 */
export function httpRequestGet<T>(url: string,
  params?: string | Object | ArrayBuffer,
  header?: HttpHeaderInterface,
  expectDataType?: http.HttpDataType): Promise<T> {
  let httpRequest = http.createHttp()
  httpRequest.on('headersReceive', (header) => {
    console.debug('===headersReceive：' + JSON.stringify(header))
  })
  let options: http.HttpRequestOptions = {
    method: http.RequestMethod.GET,
    header: header ? header.getHeader() : defaultHeader,
    extraData: params, //参数
    expectDataType: expectDataType ? expectDataType : http.HttpDataType.STRING, //指定返回数据的类型
    // readTimeout:readTimeout,
    // connectTimeout:connectTimeout,
    // usingCache: true, //是否开启缓存 默认true
    // priority: 1, //优先级 默认为1
    // usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
    // usingProxy: false, // 可选，默认不使用网络代理，自API 10开始支持该属性
    // caPath: '/path/to/cacert.pem', // 可选，默认使用系统预制证书，自API 10开始支持该属性
    // clientCert: {
    //   // 可选，默认不使用客户端证书，自API 11开始支持该属性
    //   certPath: '/path/to/client.pem', // 默认不使用客户端证书，自API 11开始支持该属性
    //   keyPath: '/path/to/client.key', // 若证书包含Key信息，传入空字符串，自API 11开始支持该属性
    //   certType: http.CertType.PEM, // 可选，默认使用PEM，自API 11开始支持该属性
    //   keyPassword: "passwordToKey", // 可选，输入key文件的密码，自API 11开始支持该属性
    // },
    // multiFormDataList: [// 可选，仅当Header中，'content-Type'为'multipart/form-data'时生效，自API 11开始支持该属性
    //   {
    //     name: "Part1", // 数据名，自API 11开始支持该属性
    //     contentType: 'text/plain', // 数据类型，自API 11开始支持该属性
    //     data: 'Example data', // 可选，数据内容，自API 11开始支持该属性
    //     remoteFileName: 'example.txt' // 可选，自API 11开始支持该属性
    //   }, {
    //   name: "Part2", // 数据名，自API 11开始支持该属性
    //   contentType: 'text/plain', // 数据类型，自API 11开始支持该属性
    //   // data/app/el2/100/base/com.example.myapplication/haps/entry/files/fileName.txt
    //   filePath: `${getContext(this).filesDir}/fileName.txt`, // 可选，传入文件路径，自API 11开始支持该属性
    //   remoteFileName: 'fileName.txt' // 可选，自API 11开始支持该属性
    // }
    // ]

  }

  return baseHttp<T>(httpRequest, url, options)
}

export function httpRequestPost<T>(url: string,
  params?: string | Object | ArrayBuffer,
  header?: HttpHeaderInterface,
  expectDataType?: http.HttpDataType) {
  let httpRequest = http.createHttp()
  httpRequest.on('headersReceive', (header: Object) => {
    console.info('===headersReceive: ' + JSON.stringify(header));
  });
  // 用于订阅HTTP流式响应数据接收事件
  let res = new ArrayBuffer(0);
  httpRequest.on('dataReceive', (data: ArrayBuffer) => {
    const newRes = new ArrayBuffer(res.byteLength + data.byteLength);
    const resView = new Uint8Array(newRes);
    resView.set(new Uint8Array(res));
    resView.set(new Uint8Array(data), res.byteLength);
    res = newRes;
    console.info('res length: ' + res.byteLength);
  });

  // 用于订阅HTTP流式响应数据接收完毕事件
  httpRequest.on('dataEnd', () => {
    console.info('===No more data in response, data receive end');
  });

  httpRequest.on('dataReceiveProgress', (data: ResProgressData) => {
    console.log("===dataReceiveProgress receiveSize:" + data.receiveSize + ", totalSize:" + data.totalSize);
  });

  let streamInfo: http.HttpRequestOptions = {
    method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
    // 开发者根据自身业务需要添加header字段
    header: header ? header.getHeader() : defaultHeader,
    // 当使用POST请求时此字段用于传递请求体内容，具体格式与服务端协商确定
    extraData: params,
    expectDataType: expectDataType ? expectDataType : http.HttpDataType.STRING, // 可选，指定返回数据的类型
    usingCache: true, // 可选，默认为true
    priority: 1, // 可选，默认为1
    connectTimeout: 60000, // 可选，默认为60000ms
    readTimeout: 60000, // 可选，默认为60000ms。若传输的数据较大，需要较长的时间，建议增大该参数以保证数据传输正常终止
    usingProtocol: http.HttpProtocol.HTTP1_1 // 可选，协议类型默认值由系统自动指定
  }
  // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
  httpRequest.requestInStream(url, streamInfo).then((data: number) => {
    console.info("===requestInStream OK!");
    console.info('===ResponseCode :' + JSON.stringify(data));
    // 取消订阅HTTP响应头事件
    httpRequest.off('headersReceive');
    // 取消订阅HTTP流式响应数据接收事件
    httpRequest.off('dataReceive');
    // 取消订阅HTTP流式响应数据接收进度事件
    httpRequest.off('dataReceiveProgress');
    // 取消订阅HTTP流式响应数据接收完毕事件
    httpRequest.off('dataEnd');
    // 当该请求使用完毕时，调用destroy方法主动销毁
    httpRequest.destroy();
  }).catch((err: Error) => {
    console.info("requestInStream ERROR : err = " + JSON.stringify(err));
  });


}

// 用于订阅HTTP流式响应数据接收进度事件
class ResProgressData {
  receiveSize: number = 0;
  totalSize: number = 0;
}
