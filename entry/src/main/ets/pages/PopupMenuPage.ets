import promptAction from '@ohos.promptAction'
import thermal from '@ohos.thermal'
import { CommonButton, CommonTitle } from './component/MyComponent'

@Entry
@Component
struct PopupMenuPage {
  @State isShowPopup: boolean = false
  @State isShowPopupWithButton: boolean = false
  @State isShowPopupCustom: boolean = false
  @State isShowMenu: boolean = false
  private scroller: Scroller = new Scroller()
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({ content: '你的账号可能在别的设备登录',
      onCancel: this.onDialogCancel,
      onConfirm: this.onDialogConfirm })
  , alignment: DialogAlignment.Bottom, offset: { dx: 0, dy: -30 }
  })

  onDialogCancel() {
    promptAction.showToast({ message: 'Dialog取消' })
  }

  onDialogConfirm() {
    promptAction.showToast({ message: 'Dialog确定' })
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '气泡' })
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
        CommonTitle({ title: '菜单' })
        //普通菜单
        CommonButton({ text: '普通菜单' })
          .onClick(() => {
            this.isShowMenu = !this.isShowMenu
          })
          .bindMenu(//是个数组
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

        CommonTitle({ title: '弹窗：AlertDialog' })
        //AlertDialog
        CommonButton({ text: 'AlertDialogParamWithConfirm' })
          .onClick(() => {
            AlertDialog.show({
              title: '温馨提示',
              message: '确定退出登录？',
              autoCancel: true,
              alignment: DialogAlignment.Center,
              offset: { dx: 0, dy: 30 },
              gridCount: 3,
              confirm: {
                value: '确定',
                fontColor: Color.White,
                backgroundColor: Color.Red,
                action: () => {
                  promptAction.showToast({ message: '确定' })
                }
              },
              cancel: () => {
                promptAction.showToast({ message: '取消' })
              }
            })
          })
        CommonButton({ text: 'AlertDialogParamWithButtons' })
          .onClick(() => {
            AlertDialog.show(
              {
                title: '温馨提示',
                message: '是否要清除缓存？',
                autoCancel: true,
                alignment: DialogAlignment.Bottom,
                gridCount: 4,
                offset: { dx: 0, dy: -20 },
                primaryButton: {
                  value: 'NO',
                  action: () => {
                    promptAction.showToast({ message: 'NO' })
                  }
                },
                secondaryButton: {
                  value: 'OK',
                  action: () => {
                    promptAction.showToast({ message: 'OK' })

                  }
                },
                cancel: () => {
                  console.info('Closed callbacks')
                }
              }
            )
          })
        CommonButton({ text: 'ActionSheet' })
          .onClick(() => {
            ActionSheet.show({
              title: '请选择',
              message: '以下您可以选择',
              alignment: DialogAlignment.Bottom,
              offset: { dx: 0, dy: -20 },
              autoCancel: true,
              confirm: {
                value: '确定',
                action: () => {

                }
              },
              cancel: () => {

              },
              sheets: [
                {
                  icon: $r('app.media.tab_home_t'),
                  title: '啊啊啊啊啊啊啊啊啊啊啊啊啊',
                  action: () => {
                    promptAction.showToast({ message: '啊啊啊啊啊啊啊啊啊啊啊啊啊' })
                  }
                },
                {
                  icon: $r('app.media.tab_info_t'),
                  title: '啦啦啦啦啦啦啦啦啦啦啦啦啦',
                  action: () => {
                    promptAction.showToast({ message: '啦啦啦啦啦啦啦啦啦啦啦啦啦' })
                  }
                },
                {
                  icon: $r('app.media.tab_find_t'),
                  title: '嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎',
                  action: () => {
                    promptAction.showToast({ message: '嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎嘎' })
                  }
                },
                {
                  icon: $r('app.media.tab_my_t'),
                  title: '哈哈哈哈哈哈哈哈哈哈哈哈哈',
                  action: () => {
                    promptAction.showToast({ message: '哈哈哈哈哈哈哈哈哈哈哈哈哈' })
                  }
                }
              ]
            })
          })
        //自定义弹窗
        CommonButton({ text: '自定义弹窗' })
          .onClick(() => {
            this.dialogController.open()
          })
        CommonTitle({ title: '选择器' })
        CommonButton({ text: 'DatePickerDialog' })
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date(2000, 1, 1),
              end: new Date(2050, 12, 31),
              selected: new Date(2024, 4, 19),
              lunar: false,
              onAccept: (value: DatePickerResult) => {
                promptAction.showToast({ message: value.year + '-' + value.month + '-' + value.day })
              },
              onCancel: () => {

              },
              onChange: (value: DatePickerResult) => {
                console.debug('滑动：' + value.year + '-' + value.month + '-' + value.day)
              }
            })
          })

        CommonButton({ text: 'TimePickerDialog' })
          .onClick(() => {
            TimePickerDialog.show({
              selected: new Date('2024-04-19T08:30:00'),
              useMilitaryTime: true,
              onAccept: (value: TimePickerResult) => {

              },
              onCancel: () => {

              },
              onChange: (value: TimePickerResult) => {

              }
            })
          })
        CommonButton({ text: 'TextPickerDialog' })
          .onClick(() => {
            TextPickerDialog.show({
              range: ['item1', 'item2', 'item3', 'item4', 'item5'],
              selected: 2,
              onAccept: (value: TextPickerResult) => {

              },
              onCancel: () => {

              },
              onChange: (value: TextPickerResult) => {

              }
            })
          })


      }.width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
  }

  //自定义popup
  @Builder
  popupBuilder() {
    Row({ space: 2 }) {
      Image($r('app.media.ic_delete')).width(30).height(30).margin({ left: 15 })
      Text('这是什么啊？').fontColor(Color.Red).margin({ right: 15 })
    }
    .alignItems(VerticalAlign.Center)
    .height(40)
    .padding(5)
  }

  //自定义菜单
  @Builder
  myMenu() {
    Menu() {
      MenuItem({ startIcon: $r('app.media.icon_menu'), content: '菜单1' })
        .selectIcon(true)
        .onChange((selected) => {
          if (selected) {
            promptAction.showToast({ message: '啊啊啊啊啊啊啊' })
          }
        })
      MenuItem({ startIcon: $r('app.media.icon_menu'), content: '菜单2' }).enabled(false)
      MenuItem({ startIcon: $r('app.media.icon_menu'), content: '菜单3', endIcon: $r('app.media.ic_into'),
        builder: this.SubMenu.bind(this) })

      MenuItemGroup({ header: '分组菜单栏' }) {
        MenuItem({ startIcon: $r('app.media.icon_menu'),
          content: '分组菜单1', endIcon: $r('app.media.ic_into'), })

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

@CustomDialog
struct CustomDialogExample {
  private content: string
  controller: CustomDialogController
  onCancel: () => void
  onConfirm: () => void

  build() {
    Column() {
      Text('温馨提示')
        .fontColor(Color.Black)
        .fontSize(20)
        .margin({ top: 10 })
        .fontWeight(FontWeight.Bold)
      Text(this.content)
        .fontColor(Color.Gray)
        .fontSize(15)
        .margin({ top: 10, bottom: 10 })
        .fontWeight(FontWeight.Normal)
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消', { type: ButtonType.Normal })
          .width(60)
          .height(40)
          .borderRadius(8)
          .backgroundColor(Color.Gray)
          .fontSize(13)
          .fontColor(Color.Black)
          .onClick(() => {
            this.controller.close()
            this.onCancel()
          })
        Button('确定', { type: ButtonType.Normal })
          .width(60)
          .height(40)
          .borderRadius(8)
          .backgroundColor(Color.Green)
          .fontSize(13)
          .fontColor(Color.White)
          .onClick(() => {
            this.controller.close()
            this.onConfirm()
          })
      }.width('100%')
      .margin({ top: 15, bottom: 15 })
    }
    .padding(20)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .margin(10)
    .borderRadius(10)
    .backgroundColor(Color.White)
  }
}