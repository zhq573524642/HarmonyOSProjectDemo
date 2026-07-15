export const IS_DEBUG: boolean = true

export const getBlockPuzzle: string = '/openplatfrom-authserver/captcha/get'
// 校验滑块图片 host.API_CLOUD_URL +
export const checkBlockPuzzle: string = '/openplatfrom-authserver/captcha/check'
export const API_CLOUD_URL: string = IS_DEBUG ? 'https://apicloudtest.yiboshi.com' : 'https://apicloud.yiboshi.com'