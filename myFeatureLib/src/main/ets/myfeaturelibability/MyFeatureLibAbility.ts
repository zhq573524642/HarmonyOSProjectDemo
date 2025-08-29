import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { UIContext } from '@kit.ArkUI';

export default class MyFeatureLibAbility extends UIAbility {
  funcAbilityWant: Want | undefined = undefined;
  uiContext: UIContext | undefined = undefined

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    //别的UIAbility跳转过来，从Want中拿到参数数据保存在AppStorage
    console.debug('===onCreate-MyFeatureLibAbility')
    this.funcAbilityWant = want
    AppStorage.setOrCreate<Want>('startAbilityInfo', this.funcAbilityWant)
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.debug('===onNewWant-MyFeatureLibAbility')
    //保存打开此Ability传递的参数信息
    this.funcAbilityWant = want
    AppStorage.setOrCreate<Want>('startAbilityInfo', this.funcAbilityWant)
    if (this.funcAbilityWant?.parameters?.page_router &&
      this.funcAbilityWant?.parameters?.page_router === 'thirdPage') {
      let pageUrl = 'pages/ThirdPage'
      if (this.uiContext) {
        let router = this.uiContext.getRouter()
        router.pushUrl({
          url: pageUrl
        })
      }
    }
  }

  onDestroy(): void {
    console.debug('===onDestroy-MyFeatureLibAbility')
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    //通过传递的参数获取对应的页面
    let url: string = 'pages/Index'
    if (this.funcAbilityWant?.parameters?.page_router && this.funcAbilityWant.parameters.page_router === 'secondPage') {
      url = 'pages/SecondPage'
    }
    windowStage.loadContent(url, (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
    //获取Window，获取UIContext
    let windowClass: window.Window;
    windowStage.getMainWindow((err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag',
          `Failed to obtain the main window. Code is ${err.code}, message is ${err.message}`);
        return;
      }
      windowClass = data;
      this.uiContext = windowClass.getUIContext();
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
