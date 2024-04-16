import promptAction from '@ohos.promptAction'
import { CommonButton } from './component/MyComponent'

@Entry
@Component
struct PopupMenuPage {
  @State isShowPopup: boolean = false
  @State isShowPopupWithButton: boolean = false
  @State isShowPopupCustom: boolean = false
  @State isShowMenu: boolean = false

  build() {
    Column() {
      CommonButton({ text: '普通气泡' })
        .onClick(() => {
          this.isShowPopup = !this.isShowPopup
        })
        .bindPopup(this.isShowPopup, {
          message: '这是popup',
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.isShowPopup = false
            }
          }
        })
      //带按钮的popup
      CommonButton({ text: '带按钮气泡' })
        .onClick(() => {
          this.isShowPopupWithButton = !this.isShowPopupWithButton
        })
        .bindPopup(this.isShowPopupWithButton, {
          message: '这是popup',
          primaryButton: {
            value: '确定',
            action: () => {
              this.isShowPopupWithButton = false
            }
          },
          secondaryButton: {
            value: '取消',
            action: () => {
              this.isShowPopupWithButton = false
            }
          },
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.isShowPopupWithButton = false
            }
          }
        })
      //自定义气泡
      CommonButton({ text: '自定义气泡' })
        .onClick(() => {
          this.isShowPopupCustom = !this.isShowPopupCustom
        })
        .bindPopup(this.isShowPopupCustom, {
          builder: this.popupBuilder,
          placement: Placement.BottomRight, //弹出的位置
          popupColor: Color.Orange, //popup背景色
          maskColor: Color.Green,
          enableArrow: true, //是否显示popup的小箭头，默认为true
          autoCancel: true, //是否可以点击popup外部区域取消，默认为true
          showInSubWindow: false, //是否显示popup在子window中，会在新的window中显示，默认为false
          arrowOffset: -100, //popup小箭头偏移位置，默认中间为0，右边为正值，左边为负值，默认为0
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.isShowPopupCustom = false
            }
          }
        })

      Text()
        .onClick(() => {

        })
        .bindPopup(this.isShowPopupCustom, {
          builder: this.popupBuilder,
          placement: Placement.Bottom, //弹出的位置
          popupColor: Color.Orange, //popup背景色
          maskColor: Color.Green,
          enableArrow: true, //是否显示popup的小箭头，默认为true
          autoCancel: true, //是否可以点击popup外部区域取消，默认为true
          showInSubWindow: false, //是否显示popup在子window中，会在新的window中显示，默认为false
          arrowOffset: -100, //popup小箭头偏移位置，默认中间为0，右边为正值，左边为负值，默认为0
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.isShowPopupCustom = false
            }
          }
        })

      //普通菜单
      CommonButton({ text: '普通菜单' })
        .onClick(() => {
          this.isShowMenu = !this.isShowMenu
        })
        .bindMenu( //是个数组
          [
            { value: '菜单Item1',
              action: () => {
                promptAction.showToast({ message: '菜单Item1', duration: 2000 })
              } },
            { value: '菜单Item2',
              action: () => {
                promptAction.showToast({ message: '菜单Item2', duration: 2000 })
              } },
            { value: '菜单Item3',
              action: () => {
                promptAction.showToast({ message: '菜单Item3', duration: 2000 })
              } },
            { value: '菜单Item4',
              action: () => {
                promptAction.showToast({ message: '菜单Item4', duration: 2000 })
              } },
            { value: '菜单Item5',
              action: () => {
                promptAction.showToast({ message: '菜单Item5', duration: 2000 })
              } }
          ]
        )
      CommonButton({ text: '自定义菜单' })
        .bindMenu(this.myMenu)

    }.width('100%')
    .height('100%')
  }

  //自定义popup
  @Builder popupBuilder() {
    Row({ space: 2 }) {
      Image($r('app.media.ic_delete')).width(30).height(30).margin({ left: 15 })
      Text('这是什么啊？').fontColor(Color.Red).margin({ right: 15 })
    }
    .alignItems(VerticalAlign.Center)
    .height(40)
    .padding(5)
  }

  //自定义菜单
  @Builder myMenu() {
    Menu() {
      MenuItem({ startIcon: $r('app.media.icon_menu'), content: '菜单1'})
        .selectIcon(true)
        .onChange((selected)=>{
          if (selected) {
             promptAction.showToast({message:'啊啊啊啊啊啊啊'})
          }
        })
      MenuItem({ startIcon: $r('app.media.icon_menu'), content: '菜单2' }).enabled(false)
      MenuItem({ startIcon: $r('app.media.icon_menu'), content: '菜单3', endIcon: $r('app.media.ic_into'),
        builder:this.SubMenu.bind(this)})

      MenuItemGroup({ header: '分组菜单栏' }) {
        MenuItem({ startIcon: $r('app.media.icon_menu'),
          content: '分组菜单1', endIcon: $r('app.media.ic_into'),})

        MenuItem({ startIcon: $r('app.media.icon_menu'), content: '分组菜单2', endIcon: $r('app.media.ic_into') })
        MenuItem({ startIcon: $r('app.media.icon_menu'), content: '分组菜单3', endIcon: $r('app.media.ic_into') })
      }

      MenuItem({ startIcon: $r('app.media.icon_menu'), content: '菜单4', endIcon: $r('app.media.ic_into') })

    }
  }

  @Builder
  SubMenu() {
    Menu() {
      MenuItem({ content: "复制", labelInfo: "Ctrl+C" })
      MenuItem({ content: "粘贴", labelInfo: "Ctrl+V" })
    }
  }
}