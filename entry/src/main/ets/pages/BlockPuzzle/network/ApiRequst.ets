import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { IS_DEBUG } from './Constants';
import Logger from './Logger';


axios.defaults.baseURL = IS_DEBUG ? 'https://apicloudtest.yiboshi.com' : 'https://apicloud.yiboshi.com'

export function setHost(hostUrl: string) {
  axios.defaults.baseURL = hostUrl
}
export function setHeader(key:string,value:string) {
  axios.defaults.headers.common[key]=value
}

//添加请求拦截器
axios.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  Logger.debug("请求--------"+JSON.stringify(config.params)+"====")
  if (config.method == 'get' || config.method == 'GET') {
    Logger.debug(`请求${config.method}=${config.baseURL}${config.url}`, JSON.stringify(config.headers),
      JSON.stringify(config.params))
  }
  else {
    Logger.debug(`请求${config.method}=${config.baseURL}${config.url}`, JSON.stringify(config.headers),
      JSON.stringify(config.data ?? config.params))
  }
  // 对请求数据做点什么
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});

// 添加响应拦截器
axios.interceptors.response.use((response: AxiosResponse) => {
  Logger.debug('响应='+response?.config.baseURL + response.config.url,JSON.stringify(response.config.params), JSON.stringify(response.data))
  // 对响应数据做点什么
  return response;
}, (error: AxiosError) => {
  // 对响应错误做点什么
  Logger.debug('响应 error='+error.response?.config.baseURL+error.response?.config.url + error.message)
  return Promise.reject(error);
});

export default axios