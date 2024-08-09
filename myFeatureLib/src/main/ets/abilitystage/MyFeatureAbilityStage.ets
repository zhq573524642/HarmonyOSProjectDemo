import { AbilityStage, Want } from '@kit.AbilityKit';

export default class MyFeatureAbilityStage extends AbilityStage{

  onCreate(): void {
  }

  onAcceptWant(want: Want): string {
    return 'MyFeatureAbilityStage'
  }

  onDestroy(): void {
  }
}