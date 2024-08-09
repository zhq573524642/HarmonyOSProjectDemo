import { AbilityStage, Want } from '@kit.AbilityKit'

export default class MyAbilityStage extends AbilityStage {
  onCreate(): void {
    // 应用的HAP在首次加载的时，为该Module初始化操作
    console.debug('===module开始加载')
    let abilityStageContext = this.context
  }


  onAcceptWant(want: Want): string {
    return''
  }

  onDestroy(): void {
    console.debug('===module销毁')
  }
}