import util from '@ohos.util';
import { buffer } from '@kit.ArkTS';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { BusinessError } from '@kit.BasicServicesKit';

/**
 * @Author csx
 * @DateTime 2024/3/19 21:42
 * @TODO CryptoUtil  加解密工具类
 */
export class CryptoUtil {


  /**
     * 加密方法 使用AES128 ECB PKCS7 加密方式
   *
   * @param text 需要加密的明文
   * @param key 加密密钥
   * @returns 返回加密结果
   */
  static encodeCrypto(text: string, key: string): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      let cipherAlgName = 'AES128|ECB|PKCS7'
      let symKeyGenerator = cryptoFramework.createSymKeyGenerator('AES128')
      let ivParam: cryptoFramework.IvParamsSpec = {
        algName: 'IvParamsSpec',
        iv: {
          data: CryptoUtil.stringToUint8Array(key, 16)
        }
      }
      symKeyGenerator.convertKey({
        data: CryptoUtil.stringToUint8Array(key, 16)
      }).then((symKey) => {
        let cipher = cryptoFramework.createCipher(cipherAlgName)
        cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, ivParam)
          .then(() => {
            return cipher.doFinal({ data: CryptoUtil.stringToUint8Array(text) })
          })
          .then(output => {
            let base64 = new util.Base64Helper()
            let result = base64.encodeToStringSync(output.data)
            resolve(result)
          })
          .catch((error: BusinessError) => {
            reject(error.message)
          })
      }).catch((error: BusinessError) => {
        reject(error.message)
      })
    })
  }

  /**
   * 序列化
   */
  static stringToUint8Array(str: string, len: number | null = null): Uint8Array {
    let arr: Array<number> = []
    if (len == null) {
      len = str.length
    }
    for (let i = 0; i < len; i++) {
      if (str.length > i) {
        arr.push(str.charCodeAt(i))
      } else {
        arr.push(0)
      }
    }
    return new Uint8Array(arr)
  }



}

/**
 * 非对称密钥对象
 */
export class CryptoKey {
  /**
   * 公钥
   */
  publicKey: string;
  /**
   * 私钥
   */
  privateKey: string;

  constructor(pubKey: string, priKey: string) {
    this.publicKey = pubKey;
    this.privateKey = priKey;
  }
}


//======================================================
export const base = new util.Base64Helper();
// 解密
export async function aesDecrypt(text: string, key: string){
  let globalResult = '';
  try {
    let keyc = await getKey(key);
    let cipherAlgName = 'AES128|ECB|PKCS7';
    let globalCipher = cryptoFramework.createCipher(cipherAlgName);
    let symAlgName = 'AES128';
    let symKeyGenerator = cryptoFramework.createSymKeyGenerator(symAlgName);
    let dataUint8Array = base.decodeSync(keyc);
    let keyBlob: cryptoFramework.DataBlob = { data: dataUint8Array };
    let promiseSymKey = await symKeyGenerator.convertKey(keyBlob);
    await globalCipher.init(cryptoFramework.CryptoMode.DECRYPT_MODE, promiseSymKey, null);
    let plainText: cryptoFramework.DataBlob = { data: base.decodeSync(text) };
    let result = await globalCipher.doFinal(plainText);
    globalResult = uint8ArrayToString(result.data);
    console.info('解密后的明文:' + globalResult);
  } catch (err) {
  }
  return globalResult
}
// 字节流转成可理解的字符串
export function uint8ArrayToString(array: Uint8Array) {
  // 将UTF-8编码转换成Unicode编码
  let out: string = '';
  let index: number = 0;
  let len: number = array.length;
  while (index < len) {
    let character = array[index++];
    switch (character >> 4) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        out += String.fromCharCode(character);
        break;
      case 12:
      case 13:
        out += String.fromCharCode(((character & 0x1F) << 6) | (array[index++] & 0x3F));
        break;
      case 14:
        out += String.fromCharCode(((character & 0x0F) << 12) | ((array[index++] & 0x3F) << 6) |
          ((array[index++] & 0x3F) << 0));
        break;
      default:
        break;
    }
  }
  return out;
}
// 获取密钥
async function getKey(key:string) {
  let symAlgName = 'AES128';
  let symKeyGenerator = cryptoFramework.createSymKeyGenerator(symAlgName);
  let dataUint8Array = stringToUint8Array(key);
  let keyBlob: cryptoFramework.DataBlob = { data: dataUint8Array };
  let promiseSymKey = await symKeyGenerator.convertKey(keyBlob);
  let keynew = base.encodeToStringSync(promiseSymKey.getEncoded().data); // 将密钥转换为base64存储
  return keynew;
}
// 字符串转成字节流
function stringToUint8Array(str: string) {
  return new Uint8Array(buffer.from(str, 'utf-8').buffer);
}
