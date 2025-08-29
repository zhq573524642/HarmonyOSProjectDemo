import { KVStoreManager, PermissionUtils, RouterUtil, ToastUtils } from '@ohos/common'
import { CommonButton, CommonTitle } from '../component/MyComponent'
import { common } from '@kit.AbilityKit'
import { distributedKVStore } from '@kit.ArkData'
import { BusinessError } from '@kit.BasicServicesKit'
import { data } from '@kit.TelephonyKit'
import { distributedDeviceManager } from '@kit.DistributedServiceKit'

const KVStoreId: string = 'myKvStoreId'

@Entry({ routeName: 'SingleVersionArkDataPage' })
@Component
export struct SingleVersionArkDataPage {
  static startPage() {
    RouterUtil.pushNamedRoute('SingleVersionArkDataPage')
  }

  private context = getContext(this) as common.UIAbilityContext
  @State dataShow: string = ''
  @State inputName: string = ''
  @State inputAge: string = ''
  scroller: Scroller = new Scroller()

  /**
   * 设备协同数据库，针对每条记录，Key的长度≤896 Byte，Value的长度<4 MB。

   单版本数据库，针对每条记录，Key的长度≤1 KB，Value的长度<4 MB。

   键值型数据库不支持应用程序自定义冲突解决策略。

   每个应用程序最多支持同时打开16个键值型分布式数据库。

   单个数据库最多支持注册8个订阅数据变化的回调。
   */

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '键值型分布式数据库' })
        CommonButton({ text: '1.初始化：申请权限和创建KVStoreManager' })
          .onClick(() => {
            KVStoreManager.getInstance().init('com.zhq.harmonyosdemo')
          })
        CommonButton({ text: '2.获取KVStore' })
          .onClick(() => {
            // let child1 = new distributedKVStore.FieldNode('id');
            // child1.type = distributedKVStore.ValueType.INTEGER; //字段类型
            // child1.nullable = false; //是否可为空
            // child1.default = '1'; //默认值
            // let child2 = new distributedKVStore.FieldNode('name');
            // child2.type = distributedKVStore.ValueType.STRING;
            // child2.nullable = false;
            // child2.default = 'zhangsan';
            // let child3 = new distributedKVStore.FieldNode('age');
            // child3.type = distributedKVStore.ValueType.INTEGER;
            // child3.nullable = false;
            // child3.default = '18';
            //
            // let schema = new distributedKVStore.Schema();
            // schema.root.appendChild(child1);
            // schema.root.appendChild(child2);
            // schema.root.appendChild(child3)
            // schema.indexes = ['$.id', '$.name', '$.age'];
            //
            // // 0表示COMPATIBLE模式，1表示STRICT模式。
            // schema.mode = 1;
            // // 支持在检查Value时，跳过skip指定的字节数，且取值范围为[0,4M-2]。
            // schema.skip = 0;
            KVStoreManager.getInstance().createKVStore(KVStoreId)
          })
        CommonButton({ text: '3.订阅分布式数据变化监听' })
          .onClick(() => {
            KVStoreManager.getInstance().onDataChange((data: distributedKVStore.ChangeNotification) => {
              console.debug('===订阅：' + JSON.stringify(data))
              data.deviceId
            })
          })
        TextInput({ placeholder: '请输入名称', text: $$this.inputName })
          .height(45)
          .width('80%')
        TextInput({ placeholder: '请输入年龄', text: $$this.inputAge })
          .height(45)
          .width('80%')
        CommonButton({ text: '4.put数据' })
          .onClick(() => {
            let test_key = 'test_kv_key'
            let student = new Student()
            student.id = 10
            student.name = this.inputName
            student.age = Number.parseInt(this.inputAge)
            let test_value = JSON.stringify(student)
            KVStoreManager.getInstance().putKVData(test_key, test_value)
          })
        CommonButton({ text: '4.get数据' })
          .onClick(() => {
            KVStoreManager.getInstance().getKVData('test_kv_key', (isSuccess: boolean, value: string) => {
              if (isSuccess) {
                this.dataShow = value
              }
            })
          })

        Text(this.dataShow).fontColor(Color.Red).fontSize(20).margin(10)

        CommonButton({ text: '5.取消订阅分布式数据变化监听' })
          .onClick(() => {
            KVStoreManager.getInstance().offDataChange((data: distributedKVStore.ChangeNotification) => {

            })
          })
        CommonButton({ text: '关闭kvStoreId对应的KVStore' })
          .onClick(() => {
            KVStoreManager.getInstance().closeKVStore(KVStoreId, () => {
              ToastUtils.show('关闭成功')
            })
          })
        CommonButton({ text: '删除kvStoreId对应的KVStore' })
          .onClick(() => {
            KVStoreManager.getInstance().deleteKVStore(KVStoreId, () => {
              ToastUtils.show('删除成功')
            })
          })


        CommonButton({ text: '同步到其他设备' })
          .onClick(() => {
            this.syncDataToOtherDevice()
          })

        CommonButton({ text: '键值型数据库备份' })
          .onClick(() => {
            let backupFile = 'kvBackup1'
            KVStoreManager.getInstance().backupKVStore(backupFile, (error) => {
              if (error) {
                console.debug('===备份失败：' + error.code + '--' + error.message)
                return
              }
              ToastUtils.show('备份成功')
            })
          })
        CommonButton({ text: '键值型数据库恢复' })
          .onClick(() => {
            let backupFile = 'kvBackup1'
            KVStoreManager.getInstance().restoreKVStore(backupFile, (error) => {
              if (error) {
                console.debug('===恢复备份失败：' + error.code + '--' + error.message)
                return
              }
              ToastUtils.show('恢复备份成功')
            })
          })
        CommonButton({ text: '键值型数据库删除备份' })
          .onClick(() => {
            let backupFile = ['kvBackup1']
            KVStoreManager.getInstance()
              .deleteKVStoreBackup(backupFile, (data: Array<[string, number]> | undefined, error) => {
                if (data) {
                  ToastUtils.show('删除备份成功: fileName:' + data[0].toString() + '-- result:' + data[1])
                } else {
                  if (error) {
                    console.debug('===删除备份失败：' + error.code + '--' + error.message)
                  }
                }
              })
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }

  syncDataToOtherDevice() {
    let devManager: distributedDeviceManager.DeviceManager;
    try {
      //要求两个设备登录同意华为账号，链接统一wifi网络，蓝牙开启但不需互联
      // create deviceManager
      devManager = distributedDeviceManager.createDeviceManager(this.context.applicationInfo.name);
      // deviceIds由deviceManager调用getAvailableDeviceListSync方法得到
      let deviceIds: string[] = [];
      if (devManager != null) {
        let devices = devManager.getAvailableDeviceListSync();
        console.debug('===设备列表' + devices.length)
        for (let i = 0; i < devices.length; i++) {
          deviceIds[i] = devices[i].deviceId as string;
        }
      }
      console.debug('===设备Id:' + JSON.stringify(deviceIds))

      try {
        KVStoreManager.getInstance().kvStore?.enableSync(true, (e) => {
          if (e) {
            console.debug('===允许同步失败：' + e.code + '--' + e.message)
            return
          }
          console.debug('===允许同步成功')
          KVStoreManager.getInstance()
            .kvStore?.sync(['f7dba26dae61b6ce46a1e58f6353bcb6c70ff13cc2fcf92cf2098cfba5d6837c'],
            distributedKVStore.SyncMode.PUSH_PULL, 2000);
        })
        // 1000表示最大延迟时间为1000ms
      } catch (e) {
        let error = e as BusinessError;
        console.error(`===An unexpected error occurred. Code:${error.code},message:${error.message}`);
      }

    } catch (err) {
      let error = err as BusinessError;
      console.error("===createDeviceManager errCode:" + error.code + ",errMessage:" + error.message);
    }
  }
}

class Student {
  id: number = 0
  name: string = ''
  age: number = 0
}