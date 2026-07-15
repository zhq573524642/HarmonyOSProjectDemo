export enum AxioErrEnum {

  ERR_FR_TOO_MANY_REDIRECTS = '许多重定向',
  ERR_BAD_OPTION_VALUE ='选项值是无效的或不适用',
  ERR_BAD_OPTION ='请求时传递了一个无效的选项',
  ERR_NETWORK='请检测您的网络',
  ERR_DEPRECATED = '',
  ERR_BAD_RESPONSE = '响应失败',
  ERR_BAD_REQUEST = '请求失败',
  ERR_NOT_SUPPORT = '不支持',
  ERR_INVALID_URL = '无效url',
  ERR_CANCELED = '请求被中止，可能是由用户调用 cancel 方法导致的',
  ECONNABORTED = '请求被中止，通常是由于超时',
  ETIMEDOUT = '请求超时',

  ECONNREFUSED = '连接被拒绝，服务器无法处理请求',

  ECONNRESET = '连接被重置',

  ENOTFOUND = '请求的 URL 无法解析',

  Z_DATA_ERROR = '解压数据时发生错误',

  FETCH_ERROR = '在 fetch 过程中出现错误'

}

