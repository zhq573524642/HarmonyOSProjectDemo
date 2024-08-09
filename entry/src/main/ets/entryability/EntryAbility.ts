import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { BusinessError } from '@kit.BasicServicesKit';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import { webview } from '@kit.ArkWeb';
import { UIContext } from '@kit.ArkUI';

const localStorage: LocalStorage = new LocalStorage('uiContext');
export default class EntryAbility extends UIAbility {
  storage: LocalStorage = localStorage;
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    //开启web前进后退缓存
    // let features = new webview.BackForwardCacheSupportedFeatures();
    // features.nativeEmbed = true;
    // features.mediaTakeOver = true;
    // webview.WebviewController.enableBackForwardCache(features);
    //网页预解析、预连接
    webview.WebviewController.initializeWebEngine()
    webview.WebviewController.prepareForPageLoad('https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-models-V5',true,2)
  }


  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  myParam: Record<string, number> = {
    'uiAbility_param': 30
  };
  localStorage: LocalStorage = new LocalStorage(this.myParam)

  windowStage: window.WindowStage | undefined = undefined;

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    this.windowStage = windowStage
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    try {
      windowStage.on('windowStageEvent', (data) => {
        let stageEventType: window.WindowStageEventType = data;
        switch (stageEventType) {
          case window.WindowStageEventType.SHOWN: // 切到前台
            console.info('testTag--windowStage foreground.');
            break;
          case window.WindowStageEventType.ACTIVE: // 获焦状态
            console.info('testTag--windowStage active.');
            break;
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            console.info('testTag--windowStage inactive.');
            break;
          case window.WindowStageEventType.HIDDEN: // 切到后台
            console.info('testTag--windowStage background.');
            break;
          default:
            break;
        }
      });
    } catch (exception) {
      console.error('Failed to enable the listener for window stage event changes. Cause:' + JSON.stringify(exception));
    }
    windowStage.loadContent('pages/ui/MainPage', this.localStorage, (err, data) => {
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

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onNewWant');
  }

  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageWillDestroy');
  }

  onWindowStageRestore(windowStage: window.WindowStage): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageRestore');
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');

    // 释放UI资源
    // 例如在onWindowStageDestroy()中注销获焦/失焦等WindowStage事件
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

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
