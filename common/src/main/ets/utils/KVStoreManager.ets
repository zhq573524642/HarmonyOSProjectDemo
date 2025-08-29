import { PermissionUtils } from "./PermissionUtils";
import { common } from "@kit.AbilityKit";
import { ToastUtils } from "./ToastUtils";
import { distributedKVStore } from "@kit.ArkData";
import { BusinessError } from "@kit.BasicServicesKit";

export class KVStoreManager {
  private static instance: KVStoreManager;
  private context = getContext(this) as common.UIAbilityContext;
  kvStoreManager: distributedKVStore.KVManager | undefined = undefined
  kvStore: distributedKVStore.SingleKVStore | undefined = undefined
  private bundleName: string = 'com.zhq.harmonyosdemo'

  constructor() {

  }

  public static getInstance(): KVStoreManager {
    if (!KVStoreManager.instance) {
      KVStoreManager.instance = new KVStoreManager()
    }
    return KVStoreManager.instance
  }

  init(bundleName: string) {
    PermissionUtils.getInstance()
      .reqPermissionFromUser(this.context, 'ohos.permission.DISTRIBUTED_DATASYNC', (result: boolean) => {
        if (result) {
          this.bundleName = bundleName
          this.createKVStoreManager()
        } else {
          ToastUtils.show('未获取权限')
        }
      })
  }

  private createKVStoreManager() {
    //创建一个KVManager对象实例，用于管理数据库对象。
    try {
      let kvStoreManager = distributedKVStore.createKVManager({
        bundleName: this.bundleName,
        context: this.context
      })
      if (kvStoreManager !== undefined) {
        this.kvStoreManager = kvStoreManager
        ToastUtils.show('创建KVStoreManager成功')
      }
    } catch (e) {
      console.debug(`===CreateKVManager异常：${e.code}--${e.message}`)
    }
  }

  createKVStore(kvStoreId: string, options?: distributedKVStore.Options, schema?: distributedKVStore.Schema) {
    //指定options和storeId，创建并得到指定类型的KVStore数据库。
    if (this.kvStoreManager) {
      let opt: distributedKVStore.Options
      if (options) {
        opt = options
      } else {
        opt = {
          createIfMissing: true, //当数据库文件不存在时是否创建
          encrypt: false, //是否加密
          backup: false, //是否备份
          autoSync: false, //是否自动同步
          // kvStoreType不填时，默认创建多设备协同数据库
          // 多设备协同数据库：kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
          kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
          // schema 可以不填，在需要使用schema功能时可以构造此参数，例如：使用谓词查询等。
          schema: schema,
          securityLevel: distributedKVStore.SecurityLevel.S3
        };
      }
      this.kvStoreManager?.getKVStore<distributedKVStore.SingleKVStore>(kvStoreId, opt,
        (error: BusinessError, store: distributedKVStore.SingleKVStore) => {
          if (error) {
            ToastUtils.show('创建键值型数据库失败：' + error.code + '--' + error.name + '--' + error.message)
            return
          }
          //获取成功
          this.kvStore = store
          ToastUtils.show('创建KVStore成功')
        })
    } else {
      ToastUtils.show('KVStoreManager为空')
    }
  }

  putKVData(key: string, value: string = '') {
    if (this.kvStore !== undefined) {
      this.kvStore.put(key, value, (error: BusinessError) => {
        if (error) {
          ToastUtils.show(`PutError:${error.code}-${error.name}-${error.message}`)
          return
        }
        ToastUtils.show('put数据成功')
      })
    }
  }

  getKVData(key: string, onResult: (isSuccess: boolean, value: string) => void) {
    if (this.kvStore !== undefined) {
      this.kvStore.get(key, (error: BusinessError, data) => {
        if (error) {
          ToastUtils.show(`GetError:${error.code}-${error.name}-${error.message}`)
          onResult?.(false, '')
          return
        }
        onResult?.(true, JSON.stringify(data))

      })
    }

  }

  onDataChange(callback: (data: distributedKVStore.ChangeNotification) => void) {
    try {
      if (this.kvStore) {
        this.kvStore.on('dataChange', distributedKVStore.SubscribeType.SUBSCRIBE_TYPE_ALL, (data) => {
          callback?.(data)
        });
      }

    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. code:${error.code},message:${error.message}`);
    }
  }

  offDataChange(callback: (data: distributedKVStore.ChangeNotification) => void) {
    try {
      if (this.kvStore) {
        this.kvStore.off('dataChange', (data) => {
          callback?.(data)
        })
      }

    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. code:${error.code},message:${error.message}`);
    }
  }

  //关闭数据库
  closeKVStore(kvStoreId: string, callback: () => void) {
    try {
      if (this.kvStoreManager) {
        this.kvStoreManager.closeKVStore(this.bundleName, kvStoreId, (e: BusinessError) => {
          if (e) {
            console.error(`===CloseKVStoreError：KVStoreId:${kvStoreId}}--info:${e.code}-${e.name}-${e.message}`)
            return
          }
          callback?.()
        })
      }
    } catch (e) {
      console.error(`===CloseKVStoreThrowable：KVStoreId:${kvStoreId}}--info:${e.code}-${e.name}-${e.message}`)
    }
  }

  //删除数据库
  deleteKVStore(kvStoreId: string, callback: () => void) {
    try {
      if (this.kvStoreManager) {
        this.kvStoreManager.deleteKVStore(this.bundleName, kvStoreId, (e: BusinessError) => {
          if (e) {
            console.error(`===DeleteKVStoreError：KVStoreId:${kvStoreId}}--info:${e.code}-${e.name}-${e.message}`)
            return
          }
          callback?.()
        })
      }
    } catch (e) {
      console.error(`===DeleteKVStoreThrowable：KVStoreId:${kvStoreId}}--info:${e.code}-${e.name}-${e.message}`)
    }
  }

  //备份数据库
  backupKVStore(backupFileName: string, callback: (error: BusinessError) => void) {
    try {
      if (this.kvStore) {
        this.kvStore.backup(backupFileName, (e) => {
          callback?.(e)
        })
      }
    } catch (e) {
      callback?.(e)
    }
  }

  //恢复备份数据库
  restoreKVStore(fileName: string, callback: (error: BusinessError) => void) {
    try {
      if (this.kvStore) {
        this.kvStore.restore(fileName, (e) => {
          callback?.(e)
        })
      }
    } catch (e) {
      callback?.(e)
    }
  }

  //删除备份的数据库 可删除多个
  deleteKVStoreBackup(fileNames: Array<string>,
    callback: (data: Array<[string, number]> | undefined, error: BusinessError | undefined) => void) {
    try {
      if (this.kvStore) {
        this.kvStore.deleteBackup(fileNames)
          .then((data) => {
            callback?.(data, undefined)
          })
          .catch((e: BusinessError) => {
            callback?.(undefined, e)
          })
      }
    } catch (e) {
      callback?.(undefined, e)
    }
  }
}