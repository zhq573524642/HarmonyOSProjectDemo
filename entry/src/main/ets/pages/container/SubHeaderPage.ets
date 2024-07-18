import { OperationType, SubHeader } from '@ohos.arkui.advanced.SubHeader'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct SubHeaderPage {
  private optionsItem: Array<SelectOption> = [
    { value: '首页', icon: $r('app.media.tab_home_f') },
    { value: '发现', icon: $r('app.media.tab_find_f') },
    { value: '消息', icon: $r('app.media.tab_info_f') },
    { value: '我的', icon: $r('app.media.tab_my_f') }
  ]

  build() {
    Column({ space: 15 }) {
      SubHeader({
        icon: $r('app.media.icon_menu'), //左侧图标
        secondaryTitle: '文本按钮（不带右箭头）',
        operationType: OperationType.BUTTON,
        select: {
          options: this.optionsItem,
          selected: 0,
          value: '菜单',
          onSelect: (index: number, value: string | undefined) => {
            promptAction.showToast({ message: 'Item:' + index })
          }
        },
        operationItem: [
          {
            value: '请选择',
            action: () => {
              promptAction.showToast({ message: '请选择' })
            }
          }
        ]
      })
        .width('100%')
        .height(50)
        .backgroundColor(Color.White)
      SubHeader({
        primaryTitle: '主标题',
        secondaryTitle: '文本按钮（带右箭头）',
        operationType: OperationType.TEXT_ARROW,
        select: {
          options: this.optionsItem,
          selected: 0,
          value: '菜单',
          onSelect: (index: number, value: string | undefined) => {
            promptAction.showToast({ message: 'Item:' + index })
          }
        },
        operationItem: [
          {
            value: '设置',
            action: () => {
              promptAction.showToast({ message: '设置' })
            }
          }
        ]
      })
        .width('100%')
        .height(50)
        .backgroundColor(Color.White)

      SubHeader({
        operationType: OperationType.ICON_GROUP,
        select: {
          options: this.optionsItem,
          selected: 0,
          value: '菜单',
          onSelect: (index: number, value: string | undefined) => {
            promptAction.showToast({ message: 'Item:' + index })
          }
        },
        iconSymbolOptions:{
          fontSize:18,
          fontWeight:FontWeight.Bold,
          fontColor:[Color.Red,Color.Yellow,Color.Green]
        },
        operationItem: [
          {
            value: $r('app.media.tab_home_f'),
            action: () => {
              promptAction.showToast({ message: '设置' })
            }
          },
          {
            value: $r('app.media.tab_my_f'),
            action: () => {
              promptAction.showToast({ message: '主题' })
            }
          }
        ]
      })
        .width('100%')
        .height(50)
        .backgroundColor(Color.White)

      SubHeader({
        icon: $r('app.media.icon_menu'), //左侧图标
        primaryTitle: '主标题',
        secondaryTitle: '副标题',
        operationType: OperationType.LOADING,
      })
        .width('100%')
        .backgroundColor(Color.White)
    }
    .width('100%')
    .backgroundColor('#f5f5f5')
    .height('100%')
  }
}