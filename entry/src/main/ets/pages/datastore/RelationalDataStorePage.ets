import { relationalStore } from '@kit.ArkData'
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { PermissionUtils, RouterUtil, ToastUtils } from '@ohos/common';
import { CommonButton } from '../component/MyComponent';
import { LengthMetrics } from '@kit.ArkUI';
import distributedDeviceManager from '@ohos.distributedDeviceManager';

@Entry({ routeName: 'RelationalDataStorePage' })
@Component
export struct RelationalDataStorePage {
  private context = getContext(this) as common.UIAbilityContext
  rdbStore: relationalStore.RdbStore | undefined = undefined
  @State dataStr: string = ''
  scroller: Scroller = new Scroller()

  static startPage() {
    RouterUtil.pushNamedRoute('RelationalDataStorePage')
  }

  aboutToAppear(): void {
    PermissionUtils.getInstance()
      .reqPermissionFromUser(this.context, 'ohos.permission.DISTRIBUTED_DATASYNC', (result: boolean) => {
        if (result) {
          ToastUtils.show('授权成功')
        } else {
          ToastUtils.show('未获取权限')
        }
      })
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '创建关系型数据库' })
          .onClick(() => {
            this.handleCreateRDBStore()
          })
        CommonButton({ text: '备份数据库' })
          .onClick(() => {
            this.handleBackupDataStore()
          })
        CommonButton({ text: '从备份数据库中恢复数据' })
          .onClick(() => {
            this.handleRestoreDataStore()
          })
        CommonButton({ text: '数据库损坏重建并恢复数据' })
          .onClick(() => {
            this.handleRebuildDataStore()
          })
        CommonButton({ text: '删除数据库' })
          .onClick(() => {
            this.handleDeleteDataStore()
          })
        CommonButton({ text: 'insert' })
          .onClick(() => {
            this.handleInsertData()
          })
        CommonButton({ text: 'update' })
          .onClick(() => {
            this.handleUpdateData()
          })
        CommonButton({ text: 'delete' })
          .onClick(() => {
            this.handleDeleteData()
          })
        CommonButton({ text: 'Query' })
          .onClick(() => {
            this.handleQueryData()
          })
        Text(this.dataStr).fontColor(Color.Blue).fontSize(18).lineSpacing(LengthMetrics.vp(5)).margin(10)
        CommonButton({ text: '订阅数据变化监听' })
          .onClick(() => {
            this.listenerDataChange()
          })
        CommonButton({ text: '取消订阅数据变化监听' })
          .onClick(() => {
            // 当前不需要订阅数据变化时，可以将其取消。
            try {
              if (this.rdbStore != undefined) {
                (this.rdbStore as relationalStore.RdbStore).off('dataChange',
                  relationalStore.SubscribeType.SUBSCRIBE_TYPE_REMOTE, (storeObserver) => {
                  });
              }
            } catch (err) {
              console.error('Failed to register observer. Code:${err.code},message:${err.message}');
            }
          })
        CommonButton({ text: '本设备push数据到其他设备' })
          .onClick(() => {
            this.syncDataPushToOtherDevices()
          })
        CommonButton({ text: '其他设备pull数据到本设备' })
          .onClick(() => {
            this.syncDataPullFromOtherDevices()
          })
        CommonButton({ text: '获取其他设备的数据库数据' })
          .onClick(() => {
            this.getRemoteDeviceTargetData()
          })
      }.width('100%')
    }.width('100%')
    .height('100%')
  }

  /**
   * 创建数据库
   */
  handleCreateRDBStore() {
    // 若希望使用分词器，可调用isStorageTypeSupported检查希望使用的分词器是否支持当前平台。
    // let tokenType = relationalStore.Tokenizer.ICU_TOKENIZER;
    // let tokenTypeSupported = relationalStore.isTokenizerSupported(tokenType);
    // if (!tokenTypeSupported) {
    //   console.error(`ICU_TOKENIZER is not supported on this platform.`);
    // }
    //自定义数据库加密密钥
    // 初始化需要使用的密钥
    let key = new Uint8Array(32);
    for (let i = 0; i < 32; i++) {
      key[i] = i;
    }

    // 初始化加密算法
    const CRYPTO_PARAM: relationalStore.CryptoParam = {
      encryptionKey: key, // 必选参数，使用指定的密钥打开加密数据库。为空则由数据库负责生成并保存密钥，并使用生成的密钥打开数据库文件。
      iterationCount: 25000, // 可选参数，迭代次数。迭代次数必须大于零。不指定或等于零则使用默认值10000和默认加密算法。
      encryptionAlgo: relationalStore.EncryptionAlgo.AES_256_CBC, // 可选参数，加密/解密算法。如不指定，默认算法为AES_256_GCM。
      hmacAlgo: relationalStore.HmacAlgo.SHA256, // 可选参数，HMAC算法。如不指定，默认值为SHA256。
      kdfAlgo: relationalStore.KdfAlgo.KDF_SHA512, // 可选参数，KDF算法。如不指定，默认值和HMAC算法相等。
      cryptoPageSize: 2048 // 可选参数，加密/解密时使用的页大小。必须为1024到65536范围内的整数并且为2的幂。如不指定，默认值为1024。
    }
    //数据库的配置设置
    const storeConfig: relationalStore.StoreConfig = {
      name: 'myRdb.db', //数据库名称
      securityLevel: relationalStore.SecurityLevel.S3, // 数据库安全级别
      encrypt: false, //指定数据库是否加密，默认不加密
      cryptoParam:CRYPTO_PARAM,//自定义加密密钥
      customDir: 'customDir/subCustomDir', // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：
      // context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，
      // '/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。
      // 当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
      isReadOnly: false, // 可选参数，指定数据库是否以只读方式打开。
      // 该参数默认为false，表示数据库可读可写。
      // 该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
      allowRebuild: true, //是否允许重建
      autoCleanDirtyData: true, //自动清除脏数据
    }
    // 判断数据库版本，如果不匹配则需进行升降级操作
    // 假设当前数据库版本为3，表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, IDENTITY)
    const SQL_CREATE_TABLE =
      'CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL, CODES BLOB, IDENTITY UNLIMITED INT)'; // 建表Sql语句, IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT
    //创建数据库
    relationalStore.getRdbStore(this.context, storeConfig, (error, store) => {
      if (error) {
        ToastUtils.show('创建数据库失败：' + error.code + '--' + error.message)
        return
      }
      ToastUtils.show('创建数据库成功')
      console.debug('===版本：' + store.version)
      // 设置分布式同步表。
      store.setDistributedTables(['EMPLOYEE']);
      // 当数据库创建时，数据库默认版本为0
      //也就是首次创建时执行最新的建表语句
      if (store.version === 0) {
        store.executeSql(SQL_CREATE_TABLE); // 创建数据表
        // 设置数据库的版本，入参为大于0的整数
        store.version = 3;
      }

      // 如果数据库版本不为0且和当前数据库版本不匹配，需要进行升降级操作
      // 当数据库存在并假定版本为1时，例应用从某一版本升级到当前版本，数据库需要从1版本升级到2版本
      if (store.version === 1) {
        // version = 1：表结构：EMPLOYEE (NAME, SALARY, CODES, ADDRESS) => version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS)
        if (store !== undefined) {
          (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE ADD COLUMN AGE INTEGER');
          store.version = 2;
        }
      }

      // 当数据库存在并假定版本为2时，例应用从某一版本升级到当前版本，数据库需要从2版本升级到3版本
      if (store.version === 2) {
        // version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS) => version = 3：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES)
        if (store !== undefined) {
          (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE DROP COLUMN ADDRESS TEXT');
          store.version = 3;
        }
      }
      this.rdbStore = store

      //加密密钥清空
      CRYPTO_PARAM.encryptionKey.fill(0)
    })
  }

  /**
   * 插入数据
   */
  handleInsertData() {
    if (this.rdbStore !== undefined) {
      let value1 = 'Lisa';
      let value2 = 18;
      let value3 = 100.5;
      let value4 = new Uint8Array([1, 2, 3, 4, 5]);
      let value5 = BigInt('15822401018187971961171');
      const valueBucket1: relationalStore.ValuesBucket = {
        'NAME': value1,
        'AGE': value2,
        'SALARY': value3,
        'CODES': value4,
        'IDENTITY': value5,
      };
      (this.rdbStore as relationalStore.RdbStore).insert('EMPLOYEE', valueBucket1,
        (error: BusinessError, rowId: number) => {
          if (error) {
            ToastUtils.show('插入数据失败：' + error.code + '--' + error.message)
            return
          }
          ToastUtils.show('插入数据成功rowId:' + rowId + '--数据：' + value1)
        })
    } else {
      ToastUtils.show('请先创建数据库')
    }
  }

  /**
   * 修改数据
   */
  handleUpdateData() {
    let value6 = 'Rose';
    let value7 = 22;
    let value8 = 200.5;
    let value9 = new Uint8Array([1, 2, 3, 4, 5]);
    let value10 = BigInt('15822401018187971967863');

    const valueBucket4: relationalStore.ValuesBucket = {
      'NAME': value6,
      'AGE': value7,
      'SALARY': value8,
      'CODES': value9,
      'IDENTITY': value10,
    };
    if (this.rdbStore !== undefined) {
      let predicates1 = new relationalStore.RdbPredicates('EMPLOYEE'); // 创建表'EMPLOYEE'的predicates
      predicates1.equalTo('NAME', 'Lisa'); // 匹配表'EMPLOYEE'中'NAME'为'Lisa'的字段  修改的匹配条件
      (this.rdbStore as relationalStore.RdbStore).update(valueBucket4, predicates1,
        (error: BusinessError, rows: number) => {
          if (error) {
            ToastUtils.show('更新数据失败：' + error.code + '--' + error.message)
            return
          }
          ToastUtils.show('更新数据成功rowId:' + rows + '--数据：' + value6)
        })
    } else {
      ToastUtils.show('请先创建数据库')
    }
  }

  /**
   * 删除数据
   */
  handleDeleteData() {
    if (this.rdbStore !== undefined) {
      let predicates1 = new relationalStore.RdbPredicates('EMPLOYEE');
      predicates1.equalTo('NAME', 'Rose');
      (this.rdbStore as relationalStore.RdbStore).delete(predicates1, (error: BusinessError, rows: number) => {
        if (error) {
          ToastUtils.show('删除失败：' + error.code + '--' + error.message)
          return
        }
        ToastUtils.show('删除成功rows:' + rows)
      })
    } else {
      ToastUtils.show('请先创建数据库')
    }
  }

  /**
   * 查询数据
   */
  handleQueryData() {
    if (this.rdbStore !== undefined) {
      let predicates = new relationalStore.RdbPredicates('EMPLOYEE')
      predicates.equalTo('NAME', 'Lisa');
      let columns: string[] = ['ID', 'NAME', 'AGE', 'SALARY', 'IDENTITY'];
      (this.rdbStore as relationalStore.RdbStore).query(predicates, columns,
        (error: BusinessError, resultSet: relationalStore.ResultSet) => {
          if (error) {
            ToastUtils.show('查询失败：' + error.code + '--' + error.message)
            return
          }
          let temps: string = ''
          temps += 'columnNames:' + resultSet.columnNames.toString() + '\n'
          temps += 'columnCount:' + resultSet.columnCount + '\n'
          while (resultSet.goToNextRow()) {
            const id = resultSet.getLong(resultSet.getColumnIndex('ID'));
            const name = resultSet.getString(resultSet.getColumnIndex('NAME'));
            const age = resultSet.getLong(resultSet.getColumnIndex('AGE'));
            const salary = resultSet.getDouble(resultSet.getColumnIndex('SALARY'));
            const identity = resultSet.getValue(resultSet.getColumnIndex('IDENTITY'));
            temps += 'id:' + id + '\n'
            temps += 'name:' + name + '\n'
            temps += 'age:' + age + '\n'
            temps += 'salary:' + salary + '\n'
            temps += 'identity:' + identity + '\n'
          }
          this.dataStr = temps
          resultSet.close()
        })
    } else {
      ToastUtils.show('请先创建数据库')
    }

  }

  /**
   * 备份数据库
   */
  handleBackupDataStore() {
    if (this.rdbStore !== undefined) {
      //"MyBackup.db"为备份数据库文件名，默认在RdbStore同路径下备份。也可指定路径：customDir + "backup.db"
      (this.rdbStore as relationalStore.RdbStore).backup('MyBackup.db', (error: BusinessError) => {
        if (error) {
          ToastUtils.show('数据库备份失败：' + error.code + '--' + error.message)
          return
        }
        ToastUtils.show('数据库备份成功')
      })
    }
  }

  handleRestoreDataStore() {
    if (this.rdbStore !== undefined) {
      (this.rdbStore as relationalStore.RdbStore).restore('MyBackup.db', (error: BusinessError) => {
        if (error) {
          ToastUtils.show('数据库恢复失败：' + error.code + '--' + error.message)
          return
        }
        ToastUtils.show('数据库恢复成功')
      })
    }
  }

  handleRebuildDataStore() {
    if (this.rdbStore !== undefined) {
      (this.rdbStore as relationalStore.RdbStore).close()
      this.rdbStore = undefined
      // 将config.allowRebuild配置为true，重新调用getRdbStore开库
      const STORE_CONFIG: relationalStore.StoreConfig = {
        name: 'myNewRdb.db',
        securityLevel: relationalStore.SecurityLevel.S3,
        encrypt: false, //指定数据库是否加密，默认不加密
        customDir: 'customDir/subCustomDir', // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：
        // context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，
        // '/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。
        // 当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
        isReadOnly: false, // 可选参数，指定数据库是否以只读方式打开。
        // 该参数默认为false，表示数据库可读可写。
        // 该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
        allowRebuild: true, //是否允许重建
        autoCleanDirtyData: true, //自动清除脏数据
      };
      relationalStore.getRdbStore(this.context, STORE_CONFIG)
        .then(async (rdbStore: relationalStore.RdbStore) => {
          this.rdbStore = rdbStore
          if (this.rdbStore !== undefined) {
            // 查看重建结果
            console.debug('===获取了rdbStore：' + this.rdbStore.rebuilt.valueOf());
            // if ((this.rdbStore as relationalStore.RdbStore).rebuilt === relationalStore.RebuildType.REBUILT) {
            // 将损坏前备份的数据恢复到新数据库中
            (this.rdbStore as relationalStore.RdbStore).restore("MyBackup.db", (err: BusinessError) => {
              if (err) {
                console.error(`===Failed to restore RdbStore. Code:${err.code}, message:${err.message}`);
                return;
              }
              ToastUtils.show('重建数据库成功')
            })
            // }
          }
        })
        .catch((error: BusinessError) => {
          ToastUtils.show('重建数据库失败：' + error.code + '--' + error.message)
        })


    }
  }

  handleDeleteDataStore() {
    relationalStore.deleteRdbStore(this.context, 'myRdb.db', (err: BusinessError) => {
      if (err) {
        ToastUtils.show('数据库删除失败：' + err.code + '--' + err.message)
        return;
      }
      ToastUtils.show('数据库删除成功')
    });
  }

  /**
   * 分布式数据同步。使用SYNC_MODE_PUSH触发同步后，数据将从本设备向组网内的其它所有设备同步。
   */
  syncDataPushToOtherDevices() {
    if (this.rdbStore !== undefined) {
      // 设置分布式同步表。
      let dmInstance = distributedDeviceManager.createDeviceManager(this.context.applicationInfo.name);
      let deviceList = dmInstance.getAvailableDeviceListSync();
      let syncTarget: string[] = [];
      deviceList.forEach(item => {
        if (item.networkId) {
          syncTarget.push(item.networkId);
        }
      });
      if (syncTarget.length == 0) {
        console.debug('===没有可同步push的设备')
        return
      }
      // this.rdbStore.setDistributedTables(['EMPLOYEE']);
      // 构造用于查询分布式表的谓词对象
      let predicates = new relationalStore.RdbPredicates('EMPLOYEE');
      //指定要同步的分布列表
      predicates.inDevices(syncTarget);
      (this.rdbStore as relationalStore.RdbStore).sync(relationalStore.SyncMode.SYNC_MODE_PUSH, predicates,
        (error: BusinessError, result) => {
          if (error) {
            ToastUtils.show('数据push同步失败：' + error.code + '--' + error.message)
            return
          }
          ToastUtils.show('数据push同步成功')
          let temps: string = ''
          for (let i = 0; i < result.length; i++) {
            temps += 'device:' + result[i][0] + '--status:' + result[i][1] + '\n'
          }
          this.dataStr = temps
        })
    }
  }

  syncDataPullFromOtherDevices() {
    if (this.rdbStore !== undefined) {
      // 设置分布式同步表。
      let dmInstance = distributedDeviceManager.createDeviceManager(this.context.applicationInfo.name);
      let deviceList = dmInstance.getAvailableDeviceListSync();
      let syncTarget: string[] = [];
      deviceList.forEach(item => {
        if (item.networkId) {
          syncTarget.push(item.networkId);
        }
      });
      if (syncTarget.length == 0) {
        console.debug('===没有可同步pull的设备')
        return
      }
      // this.rdbStore.setDistributedTables(['EMPLOYEE']);
      // 构造用于查询分布式表的谓词对象
      let predicates = new relationalStore.RdbPredicates('EMPLOYEE');
      //指定要同步的分布列表
      predicates.inDevices(syncTarget);
      (this.rdbStore as relationalStore.RdbStore).sync(relationalStore.SyncMode.SYNC_MODE_PULL, predicates,
        (error: BusinessError, result) => {
          if (error) {
            ToastUtils.show('数据Pull失败：' + error.code + '--' + error.message)
            return
          }
          ToastUtils.show('数据Pull同步成功')
          let temps: string = ''
          for (let i = 0; i < result.length; i++) {
            temps += 'device:' + result[i][0] + '--status:' + result[i][1] + '\n'
          }
          this.dataStr = temps
        })
    }
  }

  /**
   * 分布式数据订阅。数据同步变化将触发订阅回调方法执行，回调方法的入参为发生变化的设备ID。
   */
  listenerDataChange() {
    if (this.rdbStore !== undefined) {
      // 调用分布式数据订阅接口，注册数据库的观察者
      // 当分布式数据库中的数据发生更改时，将调用回调
      (this.rdbStore as relationalStore.RdbStore).on('dataChange', relationalStore.SubscribeType.SUBSCRIBE_TYPE_REMOTE,
        async (devices) => {
          for (let i = 0; i < devices.length; i++) {
            let device = devices[i];
            if (!this.rdbStore) {
              return;
            }
            console.info(`===The data of device:${device} has been changed.`);
            // 获取device对应的组网内设备分分布式表名
            const distributedTableName = await this.rdbStore.obtainDistributedTableName(device, 'EMPLOYEE');
            // 创建查询谓词，查询组网内设备分布式表的数据
            const predicates = new relationalStore.RdbPredicates(distributedTableName);
            const resultSet = await this.rdbStore.query(predicates);
            console.info(`===device ${device}, table EMPLOYEE rowCount is: ${resultSet.rowCount}`);
          }
        });
    }
  }

  getRemoteDeviceTargetData() {
    try {
      let dmInstance = distributedDeviceManager.createDeviceManager(this.context.applicationInfo.name);
      let deviceList = dmInstance.getAvailableDeviceListSync();
      const syncTarget: string[] = [];
      deviceList.forEach(item => {
        if (item.networkId) {
          syncTarget.push(item.networkId);
        }
      });
      if (syncTarget.length == 0) {
        console.debug('===没有可同步的设备')
        return
      }
      // 构造用于查询分布式表的谓词对象
      let predicates = new relationalStore.RdbPredicates('EMPLOYEE');
      //指定要同步的分布列表
      predicates.inDevices(syncTarget);
      // 调用跨设备查询接口，并返回查询结果
      if (this.rdbStore != undefined && syncTarget != undefined) {
        (this.rdbStore as relationalStore.RdbStore).remoteQuery(syncTarget[0], 'EMPLOYEE', predicates,
          ['ID', 'NAME', 'AGE', 'SALARY', 'IDENTITY'],
          (err: BusinessError, resultSet: relationalStore.ResultSet) => {
            if (err) {
              console.error(`===Failed to remoteQuery data. Code:${err.code},message:${err.message}`);
              return;
            }
            console.info(`===ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
          }
        )
      }
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      console.error("===createDeviceManager errCode:" + code + ",errMessage:" + message);
    }
  }
}