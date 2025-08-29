import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { BusinessError } from '@kit.BasicServicesKit';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import { webview } from '@kit.ArkWeb';
import { KeyboardAvoidMode, UIContext } from '@kit.ArkUI';
import { commonType, distributedDataObject } from '@kit.ArkData';
import { fileIo, fileUri } from '@kit.CoreFileKit';
import { rpc } from '@kit.IPCKit';
import { data } from '@kit.TelephonyKit';

const localStorage: LocalStorage = new LocalStorage('uiContext');

// rpc通信返回类型的实现，用于rpc通信数据序列化和反序列化
class MyParcelable implements rpc.Parcelable {
  num: number;
  str: string;

  constructor(num: number, str: string) {
    this.num = num;
    this.str = str;
  }

  marshalling(messageSequence: rpc.MessageSequence): boolean {
    messageSequence.writeInt(this.num);
    messageSequence.writeString(this.str);
    return true;
  }

  unmarshalling(messageSequence: rpc.MessageSequence): boolean {
    this.num = messageSequence.readInt();
    this.str = messageSequence.readString();
    return true;
  }
}

export default class EntryAbility extends UIAbility {
  storage: LocalStorage = localStorage;

  multiDeviceDataObject: distributedDataObject.DataObject | undefined

  uiContext: UIContext | undefined = undefined

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    //UIAbility创建完成
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    /***************************卡片服务开发*********************************/
    // 通过在GlobalContext对象上绑定filesDir，可以实现UIAbility组件与UI之间的数据同步。
    // GlobalContext.getContext().setObject("filesDir", this.context.filesDir);
    try {
      this.callee.on('functionFromWidgetCard', (data: rpc.MessageSequence) => {
        console.debug('===静态卡片调用：' + JSON.stringify(data.readString()))
        return new MyParcelable(1, '1111')
      })

      this.callee.on('functionDynamicByCall', (data: rpc.MessageSequence) => {
        console.debug('===动态卡片调用：' + JSON.stringify(data.readString()))
        return new MyParcelable(1, '222')
      })
    } catch (e) {
    }

    //开启web前进后退缓存
    let features = new webview.BackForwardCacheSupportedFeatures();
    features.nativeEmbed = true;
    features.mediaTakeOver = true;
    webview.WebviewController.enableBackForwardCache(features);
    //网页预解析、预连接
    webview.WebviewController.initializeWebEngine()
    webview.WebviewController.prepareForPageLoad('https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-models-V5',
      true, 2)


    //TODO 跨端迁移：分布式对象跨端同步  接收端
    // 2. 接收端在onCreate和onNewWant接口中创建分布式数据对象并加入组网进行数据恢复
    if (launchParam.launchReason == AbilityConstant.LaunchReason.CONTINUATION) {
      if (want.parameters && want.parameters.distributedSessionId) {
        this.restoreDistributedDataObject(want);
      }
    }

    //TODO 多端协同：被调用端被拉起后创建和恢复分布式数据对象
    if (want.parameters) {
      console.debug('===参数：' + want.parameters.distributedSessionId)
    }
    if (want.parameters && want.parameters.distributedSessionId) {
      // 3.1 创建分布式数据对象实例
      let data = new Data(undefined, undefined);
      this.multiDeviceDataObject = distributedDataObject.create(this.context, data);
      // 3.2 注册数据变更监听
      this.multiDeviceDataObject.on('change', (sessionId: string, fields: Array<string>) => {
        fields.forEach((field) => {
          console.debug('===多端协同-接收端监听：sessionId:' + sessionId + '--' + field)
        });
      });
      // 3.3 从want中获取源端放入的sessionId，使用这个sessionId加入组网
      let sessionId = want.parameters.distributedSessionId as string;
      console.debug('===接收端收到sessionId：' + sessionId)
      this.multiDeviceDataObject.setSessionId(sessionId);
    }
  }

  //当UIAbility实例已经创建，并且启动模式是singleton，再次调用startAbility启动时，走这个回调方法
  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    if (launchParam.launchReason == AbilityConstant.LaunchReason.CONTINUATION) {
      if (want.parameters && want.parameters.distributedSessionId) {
        this.restoreDistributedDataObject(want);
      }
    }
  }


  //API13开始，如果用户使用最近任务列表一键清理来关闭该UIAbility实例，将不会执行onDestroy()回调，而是会直接终止进程
  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
    try {
      this.callee.off('functionFromWidgetCard')
      this.callee.off('functionDynamicByCall')
    } catch (e) {
    }
  }

  myParam: Record<string, number> = {
    'uiAbility_param': 30
  };
  localStorage: LocalStorage = new LocalStorage(this.myParam)

  windowStage: window.WindowStage | undefined = undefined;

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    //WindowStage已经创建完成
    this.windowStage = windowStage
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    try {
      windowStage.on('windowStageEvent', (data) => {
        let stageEventType: window.WindowStageEventType = data;
        switch (stageEventType) {
          case window.WindowStageEventType.SHOWN: // 切到前台
            console.info('testTag--windowStage shown.');
            break;
          case window.WindowStageEventType.ACTIVE: // 获焦状态
            console.info('testTag--windowStage active.');
            break;
          case window.WindowStageEventType.RESUMED:
            console.info('testTag--windowStage resumed.');
            break
          case window.WindowStageEventType.PAUSED:
            console.info('testTag--windowStage paused.');
            break
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            console.info('testTag--windowStage inactive.');
            break;
          case window.WindowStageEventType.HIDDEN: // 切到后台
            console.info('testTag--windowStage hidden.');
            break;
          default:
            break;
        }
      });
    } catch (exception) {
      console.error('Failed to enable the listener for window stage event changes. Cause:' + JSON.stringify(exception));
    }
    windowStage.loadContent('pages/ui/MainPage', this.localStorage, (err, data) => {
      // 设置虚拟键盘抬起时压缩页面大小为减去键盘的高度
      windowStage.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      //获取键盘避让方式
      let keyboardAvoidMode = windowStage.getMainWindowSync().getUIContext().getKeyboardAvoidMode();
      console.debug('===当前的键盘避让方式:' + keyboardAvoidMode)
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');

    });
    // this.storage.setOrCreate<UIContext>('uiContext',windowStage.getMainWindowSync().getUIContext())

    //获取到UIContext环境
    // let window = windowStage.getMainWindow()
    // window.then(window => {
    //   let context = window.getUIContext()
    //   context.runScopedTask(() => {
    //
    //   })
    // })
    //设置窗口全屏
    // let windowClass: window.Window = windowStage.getMainWindowSync()
    // let isFullScreenLayout =true
    // windowClass.setWindowLayoutFullScreen(isFullScreenLayout)
    //   .then(() => {
    //     console.debug('===设置成功')
    //     AppStorage.setOrCreate('layoutfullscreen',true)
    //   })
    //   .catch((error: BusinessError) => {
    //     console.debug('===设置失败：' + error.message)
    //   })
    // // //获取布局避让遮挡的区域
    // let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR
    // let statusBarType=window.AvoidAreaType.TYPE_SYSTEM
    // let avoidArea = windowClass.getWindowAvoidArea(type)
    // let statusBarArea=windowClass.getWindowAvoidArea(statusBarType)
    // let statusBarHeight=statusBarArea.topRect.height//获取状态栏高度
    // let bottomRectHeight = avoidArea.bottomRect.height //获取到导航条的高度
    // AppStorage.setOrCreate('navigation_bottom_height', bottomRectHeight)
    // AppStorage.setOrCreate('status_bar_height',statusBarHeight)
  }

  //WindowStage销毁前执行
  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageWillDestroy');
    try {
      if (this.windowStage) {
        this.windowStage.off('windowStageEvent');
      }
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(0x0000, 'testTag',
        `Failed to disable the listener for windowStageEvent. Code is ${code}, message is ${message}`);
    }
  }

  onWindowStageRestore(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageRestore');
  }

  //UIAbility销毁前执行
  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');

    // 释放UI资源

  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }


  /******************************分布式对象跨设备同步*************************************/
  dataObject: distributedDataObject.DataObject | undefined = undefined

  onContinue(wantParam: Record<string, Object>): AbilityConstant.OnContinueResult | Promise<AbilityConstant.OnContinueResult> {
    try {
      console.debug('===onContinue')
      //一、分布式数据对象跨端迁移
      // 1. 迁移发起端在onContinue接口中创建分布式数据对象并保存数据到接收端
      // 1.1 调用create接口创建并得到一个分布式数据对象实例
      let attachment = this.createAttachment();
      let data = new Data('The title', 'The text', attachment);
      this.dataObject = distributedDataObject.create(this.context, data)

      // 1.2 调用genSessionId接口创建一个sessionId，调用setSessionId接口设置同步的sessionId，
      // 并将这个sessionId放入wantParam
      let sessionId = distributedDataObject.genSessionId();
      console.debug('===生成的sessionId:' + sessionId)
      this.dataObject.setSessionId(sessionId);
      wantParam.distributedSessionId = sessionId;

      // 1.3 从wantParam获取接收端设备networkId，使用这个networkId调用save接口保存数据到接收端
      let deviceId = wantParam.targetDevice as string;
      console.log(`===get deviceId: ${deviceId}`);
      this.dataObject.save(deviceId);
    } catch (e) {
      console.debug(`===continue异常：${e.code}--${e.message}`)
    }
    return AbilityConstant.OnContinueResult.AGREE;
  }

  restoreDistributedDataObject(want: Want) {
    if (!want.parameters || !want.parameters.distributedSessionId) {
      console.error('===接收端missing sessionId');
      return;
    }

    // 2.1 调用create接口创建并得到一个分布式数据对象实例
    //创建空的资产数据， 接收端需要将资产数据的各个属性设置为空字符串，才能恢复发起端保存的资产数据
    let attachment = this.createEmptyAttachment();
    let data = new Data(undefined, undefined, attachment);
    this.dataObject = distributedDataObject.create(this.context, data);

    // 2.2 注册恢复状态监听。收到状态为'restored'的回调通知时，表示接收端分布式数据对象已恢复发起端保存过来的数据（有资产数据时，对应的文件也迁移过来了）
    this.dataObject.on('status', (sessionId: string, networkId: string, status: string) => {
      if (status == 'restored') { // 收到'restored'的状态通知表示已恢复发起端保存的数据
        console.log(`===接收端恢复数据：title: ${this.dataObject['title']}, text: ${this.dataObject['text']}, attachment: ${this.dataObject['attachment']}}`);
      }
    });

    // 2.3 从want.parameters中获取发起端放入的sessionId，调用setSessionId接口设置同步的sessionId
    let sessionId = want.parameters.distributedSessionId as string;
    console.log(`===接收端get sessionId: ${sessionId}`);
    this.dataObject.setSessionId(sessionId);
  }


  // 在分布式文件目录下创建一个文件并使用资产类型记录（也可以记录分布式文件目录下已有文件，非分布式文件目录下的文件可以复制或移动到分布式文件目录下再进行记录）
  createAttachment() {
    let attachment = this.createEmptyAttachment();
    try {
      let distributedDir: string = this.context.distributedFilesDir; // 分布式文件目录
      let fileName: string = 'text_attachment.txt'; // 文件名
      let filePath: string = distributedDir + '/' + fileName; // 文件路径
      let file = fileIo.openSync(filePath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
      fileIo.writeSync(file.fd, 'The text in attachment');
      fileIo.closeSync(file.fd);
      let uri: string = fileUri.getUriFromPath(filePath); // 获取文件URI
      let stat = fileIo.statSync(filePath); // 获取文件详细属性信息

      // 写入资产数据
      attachment = {
        name: fileName,
        uri: uri,
        path: filePath,
        createTime: stat.ctime.toString(),
        modifyTime: stat.mtime.toString(),
        size: stat.size.toString()
      }
    } catch (e) {
      let err = e as BusinessError;
    }
    return attachment;
  }

  //创建空的资产文件
  createEmptyAttachment() {
    let attachment: commonType.Asset = {
      name: '',
      uri: '',
      path: '',
      createTime: '',
      modifyTime: '',
      size: ''
    }
    return attachment;
  }
}

// 业务数据定义
class Data {
  title: string | undefined;
  text: string | undefined;
  attachment: commonType.Asset;

  // 可以使用资产类型记录分布式目录下的文件，迁移资产数据时，对应的文件会一起迁移到接收端。
  // （不迁移文件时不需要此字段，下方代码中的createAttachment、createEmptyAttachment方法也都不需要。）

  // attachment2: commonType.Asset; // 暂不支持资产类型数组，如果要迁移多个文件，在业务数据中定义多条资产数据来记录

  constructor(title: string | undefined, text: string | undefined, attachment?: commonType.Asset) {
    this.title = title;
    this.text = text;
    this.attachment = attachment;
  }
}
