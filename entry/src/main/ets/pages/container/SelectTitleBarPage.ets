import { SelectTitleBar } from '@ohos.arkui.advanced.SelectTitleBar'
import { promptAction } from '@kit.ArkUI'

interface MenuItems {
  value: ResourceStr
  isEnable: boolean
  onClick?: () => void
}

@Entry
@Component
struct SelectTitleBarPage {
  private menuItems: Array<MenuItems> = [
    {
      value: $r('app.media.tab_home_t'),
      isEnable: true,
      onClick: () => {
        promptAction.showToast({ message: '菜单：0' })
      }
    },
    {
      value: $r('app.media.tab_find_t'),
      isEnable: true,
      onClick: () => {
        promptAction.showToast({ message: '菜单：1' })
      }
    },
    {
      value: $r('app.media.tab_info_t'),
      isEnable: true,
      onClick: () => {
        promptAction.showToast({ message: '菜单：2' })
      }
    },
    {
      value: $r('app.media.tab_my_t'),
      isEnable: true,
      onClick: () => {
        promptAction.showToast({ message: '菜单：3' })
      }
    }
  ]
  private optionItems: Array<SelectOption> = [
    {
      value: '首页', //内容
      icon: $r('app.media.tab_home_f'), //图片
    },
    {
      value: '消息', //内容
      icon: $r('app.media.tab_info_f'), //图片
    },
    {
      value: '发现', //内容
      icon: $r('app.media.tab_find_f'), //图片
    },
    {
      value: '我的', //内容
      icon: $r('app.media.tab_my_f'), //图片
    },
  ]

  build() {
    Column() {
      SelectTitleBar({
        options: this.optionItems,
        selected: 0, //当前选中项的索引 从0开始有效，默认为-1
        hidesBackButton: true, //是否隐藏左侧返回按钮
        onSelected: (index: number) => {
          promptAction.showToast({ message: 'Item:' + index })
        }
      })
      Divider().color(Color.Gray).width('90%').height(2)
      SelectTitleBar({
        options: this.optionItems,
        selected: 1, //当前选中项的索引 从0开始有效，默认为-1
        hidesBackButton: true, //是否隐藏左侧返回按钮
        onSelected: (index: number) => {
          promptAction.showToast({ message: 'Item:' + index })
        }
      })
      Divider().color(Color.Gray).width('90%').height(2)
      SelectTitleBar({
        options: this.optionItems,
        selected: 2, //当前选中项的索引 从0开始有效，默认为-1
        hidesBackButton: true, //是否隐藏左侧返回按钮
        subtitle: '这是副标题',
        onSelected: (index: number) => {
          promptAction.showToast({ message: 'Item:' + index })
        }
      })
      Divider().color(Color.Gray).width('90%').height(2)
      SelectTitleBar({
        options: this.optionItems,
        selected: 3, //当前选中项的索引 从0开始有效，默认为-1
        hidesBackButton: false, //是否隐藏左侧返回按钮
        subtitle: '这是副标题',
        onSelected: (index: number) => {
          promptAction.showToast({ message: 'Item:' + index })
        }
      })
      Divider().color(Color.Gray).width('90%').height(2)
      SelectTitleBar({
        options: this.optionItems,
        menuItems: this.menuItems,
        selected: 0, //当前选中项的索引 从0开始有效，默认为-1
        subtitle: '这是副标题',
        hidesBackButton: false, //是否隐藏左侧返回按钮
        badgeValue:99,
        onSelected: (index: number) => {
          promptAction.showToast({ message: 'Item:' + index })
        }
      })
      Divider().color(Color.Gray).width('90%').height(2)
    }
  }
}