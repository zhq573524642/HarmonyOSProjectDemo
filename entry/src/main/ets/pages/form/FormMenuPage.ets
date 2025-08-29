import { AddFormMenuItem } from '@ohos.arkui.advanced.FormMenu'
import { formBindingData } from '@kit.FormKit'

@Entry
@Component
struct FormMenuPage {
  build() {
    Column() {
      Image($r('app.media.img3'))
        .id('addform@123456')
        .width('100%')
        .margin(20)
        .bindContextMenu(this.MyMenu, ResponseType.LongPress, {
          placement: Placement.Bottom
        })
    }
  }

  @Builder
  MyMenu() {
    Menu() {
      AddFormMenuItem(
        {
          bundleName: 'com.zhq.harmonyosdemo',
          abilityName: 'EntryFormAbility',
          parameters: {
            'ohos.extra.param.key.form_dimension': 4, // 卡片尺寸，1代表1*2卡片，2代表2*2卡片，3代表2*4卡片，4代表4*4卡片，7代表6*4卡片，6代表1*1卡片
            'ohos.extra.param.key.form_name': 'StaticWidgetCard', // 卡片名称
            'ohos.extra.param.key.module_name': 'entry' // 卡片所属的模块名称
          }
        },
        'addform@123456',
        {
          formBindingData: formBindingData.createFormBindingData({ data: '1111' }),
          callback: (error, formId) => {
            console.debug('===信息：' + JSON.stringify(error))
            if (error?.code == 0) {
              console.debug('===添加桌面成功：' + formId)
            } else {
              console.debug('===添加桌面失败：' + formId)
            }
          },
          style: {
            options: {
              startIcon: $r('app.media.icon_menu'),
              content: '求你添加到桌面啊~',
              endIcon: $r('app.media.ic_star_second')
            }
          }
        }
      )
    }
  }
}