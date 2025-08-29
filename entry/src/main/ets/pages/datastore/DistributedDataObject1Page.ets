import { commonType, distributedDataObject } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import { fileIo, fileUri } from '@kit.CoreFileKit';
import { RouterUtil } from '@ohos/common';


@Entry({routeName:'DistributedDataObject1Page'})
@Component
export struct DistributedDataObject1Page {
  private context = getContext(this) as common.UIAbilityContext

  static startPage(){
    RouterUtil.pushNamedRoute('DistributedDataObject1Page')
  }

  build() {
    Column() {

    }.width('100%')
    .height('100%')
  }

  /**
   * 1. 迁移发起端在onContinue(UIAbility中)接口中创建分布式数据对象并保存数据到接收端
   * 创建并得到一个分布式数据对象实例。
   */
  handleCreateDistributedDataObjectInstance() {

  }


}