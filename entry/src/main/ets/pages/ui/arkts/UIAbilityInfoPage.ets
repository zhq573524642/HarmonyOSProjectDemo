import { common } from "@kit.AbilityKit"

@Entry
@Component
export struct UIAbilityInfoPage {
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext
  @State abilityInfoText: string = ''

  aboutToAppear(): void {
    this.abilityInfoText =
      'name: ' + this.context.abilityInfo.name + '\n' +
        'bundleName: ' + this.context.abilityInfo.bundleName + '\n' +
        'moduleName: ' + this.context.abilityInfo.moduleName + '\n' +
        'label: ' + this.context.abilityInfo.label + '\n' +
        'labelId: ' + this.context.abilityInfo.labelId + '\n' +
        'description :' + this.context.abilityInfo.description + '\n' +
        'descriptionId: ' + this.context.abilityInfo.descriptionId + '\n' +
        'icon: ' + this.context.abilityInfo.icon + '\n' +
        'iconId: ' + this.context.abilityInfo.iconId + '\n' +
        'process: ' + this.context.abilityInfo.process.toString() + '\n' +
        'exported: ' + this.context.abilityInfo.exported + '\n' +
        'orientation: ' + this.context.abilityInfo.orientation.toString() + '\n' +
        'launchType: ' + this.context.abilityInfo.launchType.toString() + '\n' +
        'permissions: ' + this.context.abilityInfo.permissions.toString() + '\n' +
        'deviceTypes: ' + this.context.abilityInfo.deviceTypes.toString() + '\n' +
        'metadata: ' + this.context.abilityInfo.metadata.toString() + '\n' +
        'enabled: ' + this.context.abilityInfo.enabled + '\n' +
        'supportWindowModes: ' + this.context.abilityInfo.supportWindowModes.toString() + '\n' +
        'excludeFromDock: ' + this.context.abilityInfo.excludeFromDock.valueOf() + '\n' +
        'skills: ' + this.context.abilityInfo.skills.toString() + '\n' +
        'appIndex: ' + this.context.abilityInfo.appIndex + '\n'
  }

  build() {
    Column() {
      Text(this.abilityInfoText)
        .fontSize(18)
        .padding(20)
    }.width('100%')
    .height('100%')
  }
}