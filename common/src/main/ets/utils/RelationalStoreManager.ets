import { relationalStore } from "@kit.ArkData"

export class RelationalStoreManager {
  private static instance: RelationalStoreManager

  public static getInstance(): RelationalStoreManager {
    if (!RelationalStoreManager.instance) {
      RelationalStoreManager.instance = new RelationalStoreManager()
    }
    return RelationalStoreManager.instance
  }

  createRdbStore(dbName:string,customDir?:string) {
    // 若希望使用分词器，可调用isStorageTypeSupported检查希望使用的分词器是否支持当前平台。
    // let tokenType = relationalStore.Tokenizer.ICU_TOKENIZER;
    // let tokenTypeSupported = relationalStore.isTokenizerSupported(tokenType);
    // if (!tokenTypeSupported) {
    //   console.error(`ICU_TOKENIZER is not supported on this platform.`);
    // }
    const storeConfig: relationalStore.StoreConfig = {
      name: dbName, //数据库名称
      securityLevel: relationalStore.SecurityLevel.S3, // 数据库安全级别
      encrypt: false, //指定数据库是否加密，默认不加密
      customDir: customDir, // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：
      // context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，
      // '/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。
      // 当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
      isReadOnly: false, // 可选参数，指定数据库是否以只读方式打开。
      // 该参数默认为false，表示数据库可读可写。
      // 该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
      allowRebuild:true,//是否允许重建
      autoCleanDirtyData:true,//自动清除脏数据
    }

  }
}