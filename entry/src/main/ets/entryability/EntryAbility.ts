import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { BusinessError } from '@kit.BasicServicesKit';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import { Context } from '@ohos.arkui.UIContext';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

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
    //获取到UIContext环境
    // let window = windowStage.getMainWindow()
    // window.then(window => {
    //   let context = window.getUIContext()
    //   context.runScopedTask(() => {
    //
    //   })
    // })
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
