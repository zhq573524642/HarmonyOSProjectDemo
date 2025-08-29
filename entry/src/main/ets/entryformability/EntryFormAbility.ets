import { formBindingData, FormExtensionAbility, formInfo, formProvider } from '@kit.FormKit';
import { Configuration, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

export default class EntryFormAbility extends FormExtensionAbility {
  /**
   *
   * @param want 获取卡片相关信息
   * @returns
   */
  onAddForm(want: Want) {
    //卡片使用方创建卡片时触发，提供方需要返回卡片数据绑定类
    let formId: string = want.parameters ? want.parameters[formInfo.FormParam.IDENTITY_KEY] as string : '';
    console.debug('===onAddForm：' + formId)

    let formData: Record<string, string> = {
      'title': '默认的标题',
      'detail': '默认的详情'
    };
    return formBindingData.createFormBindingData(formData);
  }

  // onCastToNormalForm(formId: string) {
  //   console.debug('===onCastToNormalForm：'+formId)
  //   // 卡片使用方将临时卡片转换为常态卡片触发，提供方需要做相应的处理。
  //   // 1、临时卡、常态卡是卡片使用方的概念。
  //   // 2、临时卡是短期存在的，在特定事件或用户行为后显示，完成后自动消失。
  //   // 3、常态卡是持久存在的，在用户未进行清除或更改的情况下，会一直存在，平时开发的功能卡片属于常态卡。
  //   // 4、目前手机上没有地方会使用临时卡。
  // }

  // onUpdateForm(formId: string) {
  //   console.debug('===onUpdateForm：'+formId)
  //  // 若卡片支持定时更新/定点更新/卡片使用方主动请求更新功能，则提供方需要重写该方法以支持数据更新
  //   //1.要更新的数据
  //   let obj: Record<string, string> = {
  //     'title': 'titleOnUpdateForm',
  //     'detail': 'detailOnUpdateForm'
  //   };
  //   //2.封装卡片数据绑定类
  //   let formData: formBindingData.FormBindingData = formBindingData.createFormBindingData(obj);
  //   //3.通过formProvider调用updateForm更新卡片数据
  //   formProvider.updateForm(formId, formData).catch((error: BusinessError) => {
  //
  //   });
  // }

  // onChangeFormVisibility(newStatus: Record<string, number>): void {
  //   // 卡片使用方发起可见或者不可见通知触发，提供方需要做相应的处理，仅系统应用生效
  //   console.debug('===onChangeFormVisibility')
  // }

  onFormEvent(formId: string, message: string) {
    // 若卡片支持触发事件，则需要重写该方法并实现对事件的触发
    console.debug('===onFormEvent' + formId + '---' + message)
    // 请根据业务替换为实际刷新的卡片数据
    let formData = new FormDataClass();
    formData.title = '更新了标题'
    formData.detail = '更新了详情'
    let formInfo: formBindingData.FormBindingData = formBindingData.createFormBindingData(formData);
    formProvider.updateForm(formId, formInfo).then(() => {
      console.debug('===更新动态卡片成功')
    }).catch((error: BusinessError) => {
      console.debug('===更新动态卡片失败：' + JSON.stringify(error))
    })
  }

  onRemoveForm(formId: string) {
    // 删除卡片实例数据
    console.debug('===onRemoveForm')
  }

  // onConfigurationUpdate(newConfig: Configuration): void {
  //   // 当前formExtensionAbility存活时更新系统配置信息时触发的回调。
  //   // 需注意：formExtensionAbility创建后10秒内无操作将会被清理。
  //   console.debug('===onConfigurationUpdate')
  // }

  // onAcquireFormState(want: Want) {
  //   // 卡片提供方接收查询卡片状态通知接口，默认返回卡片初始状态。
  //   console.debug('===onAcquireFormState')
  //   return formInfo.FormState.READY;
  // }
};

class FormDataClass {
  title: string = 'Title Update.'; // 和卡片布局中对应
  detail: string = 'Description update success.'; // 和卡片布局中对应
}