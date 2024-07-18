import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import Logger from '../utils/Logger'


axios.defaults.baseURL = 'https://apicloudtest.yiboshi.com/'

export function setHost(hostUrl: string) {
  axios.defaults.baseURL = hostUrl
}
export function setHeader(key:string,value:string) {
  axios.defaults.headers.common[key]=value
}

//添加请求拦截器
axios.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  if (config.method == 'get' || config.method == 'GET')
    Logger.debug(`request：${config.method}=${config.baseURL}${config.url}`,JSON.stringify(config.headers), JSON.stringify(config.params))
  else Logger.debug(`request：${config.method}=${config.baseURL}${config.url}`, JSON.stringify(config.headers),JSON.stringify(config.data ?? config.params))
  // 对请求数据做点什么
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});

// 添加响应拦截器
axios.interceptors.response.use((response: AxiosResponse) => {
  Logger.debug('response=' + response.config.url, JSON.stringify(response.data))
  // 对响应数据做点什么
  return response;
}, (error: AxiosError) => {
  // 对响应错误做点什么
  Logger.debug('response error='+error.response?.config.url + error.message)
  return Promise.reject(error);
});

export default axios