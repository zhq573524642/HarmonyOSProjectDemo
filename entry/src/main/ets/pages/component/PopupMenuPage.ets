import promptAction from '@ohos.promptAction'
import thermal from '@ohos.thermal'
import { TestBean } from '../../bean/TestBean'
import { CommonButton, CommonTitle } from './MyComponent'
import { BusinessError } from '@ohos.base'
import { ToastUtils } from '@ohos/common'
import { ConfirmDialog, LoadingDialog, SelectDialog, TipsDialog } from '@ohos.arkui.advanced.Dialog'
import { AlertDialog } from '@ohos.arkui.advanced.Dialog'
import { CustomColors } from '@ohos.arkui.theme'
import { PageRouter } from '../../router/PageRouter'
import { ComponentContent, curves, Font, LengthMetrics, LevelMode, RectShape, router } from '@kit.ArkUI'
import { DialogUtils } from '../../utils/DialogUtils'
import { BindContentCoverDemo } from './BindContentCoverDemo'

class DialogParams {
  title: string
  message: string

  constructor(title: string, message: string) {
    this.title = title
    this.message = message
  }
}

@Builder
function DialogContent(param: DialogParams /*, onSureClick: () => void*/) {
  Column() {
    Text(param.title)
      .fontSize(18)
      .fontColor(Color.Black)
      .fontWeight(FontWeight.Bold)
      .margin({ top: '15vp' })
    Text(param.message)
      .fontColor(Color.Black)
      .fontSize(14)
      .margin({ top: '10vp' })
    Row() {
      Button('取消')
        .backgroundColor(Color.Gray)
        .onClick(() => {
          DialogUtils.close()
        })
      Button('确定')
        .backgroundColor(Color.Yellow)
        .onClick(() => {
          // onSureClick?.()
          DialogUtils.update({ alignment: DialogAlignment.Bottom, autoCancel: true, maskColor: '#50ff0000' })
        })
    }.margin({ top: '10vp', bottom: '10vp' })
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
  .width('80%')
  .alignItems(HorizontalAlign.Center)
  .backgroundColor(Color.White)
  .border({ radius: 10 })
}

@Entry({ routeName: PageRouter.PAGE_POPUP_DIALOG })
@Component
export struct PopupMenuPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_POPUP_DIALOG
    }, router.RouterMode.Single)
  }

  uiContext: UIContext = this.getUIContext()
  private contentNode: ComponentContent<Object> =
    new ComponentContent(this.uiContext, wrapBuilder(DialogContent),
      new DialogParams("温馨提示", '确定进行此操作吗？'))
  @State isShowPopup: boolean = false
  @State isShowPopupWithButton: boolean = false
  @State isShowPopupCustom: boolean = false
  @State isShowMenu: boolean = false
  private scroller: Scroller = new Scroller()
  @State selectedDate: Date = new Date()
  @State isShowSheet: boolean = false
  @State isShowBindContentCover: boolean = false
  @State dialogList: Array<TestBean> = [
    {
      name: '1111',
      isSelected: true,
    },
    {
      name: '2222',
      isSelected: false,
    },
    {
      name: '3333',
      isSelected: false,
    },
    {
      name: '4444',
      isSelected: false,
    },

  ]
  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      list: this.dialogList,
      content: '你的账号可能在别的设备登录',
      onCancel: this.onDialogCancel,
      onConfirm: this.onDialogConfirm,
      onListItemClick: (index: number) => {
        for (let i = 0; i < this.dialogList.length; i++) {
          this.dialogList[i].isSelected = i == index
        }
      }
    }),
    cancel: () => { //弹窗cancel的回调

    },
    // width:'100%',//弹窗的宽
    // height:100,//弹窗的高
    borderWidth: 2, //边框的宽
    borderColor: Color.Orange, //边框的颜色
    borderStyle: BorderStyle.Dotted, //边框线条样式
    shadow: ({
      fill: true,
      radius: 20,
      color: Color.Red,
      offsetX: 40,
      offsetY: 40
    }),
    keyboardAvoidMode: KeyboardAvoidMode.DEFAULT, //避开键盘的模式
    isModal: true, //是否模态弹窗，模态不支持透传
    autoCancel: true, //是否点击弹窗外部取消弹窗
    alignment: DialogAlignment.Bottom, //弹出的位置
    offset: { dx: 0, dy: -30 }, //弹出位置偏移
    customStyle: false, //是否使用自定义弹窗的样式,false的话有默认的圆角矩形背景
    backgroundColor: Color.White, //背景色
    gridCount: 4, //栅栏列数，占屏幕的份数
    // maskColor: Color.Gray, //蒙层颜色
    cornerRadius: 10, //弹窗框圆角大小
    openAnimation: {
      //弹出动画
      duration: 800,
      curve: Curve.Smooth,
      delay: 200,
      playMode: PlayMode.Alternate,
      iterations: 1, //反复次数
      onFinish: () => {

      }
    },
    closeAnimation: {
      //关闭动画

    },
    onWillDismiss: (data) => { //将要取消弹窗。空实现的话可以屏蔽手机返回关闭弹窗
      //data.reason
      // 1、PRESS_BACK    点击三键back、侧滑（左滑/右滑）、键盘ESC。
      // 2、TOUCH_OUTSIDE    点击遮障层时
      // 3、CLOSE_BUTTON    点击关闭按钮
    }
  })

  onDialogCancel() {
    promptAction.showToast({ message: 'Dialog取消' })
  }

  onDialogConfirm() {
    promptAction.showToast({ message: 'Dialog确定' })
  }

  aboutToAppear(): void {
    DialogUtils.setContext(this.uiContext)
    DialogUtils.setContentNode(this.contentNode)
    DialogUtils.setOptions({ alignment: DialogAlignment.Center, autoCancel: true, maskColor: '#50ffff00' })
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: 'promptAction.showToast' })
        Row() {
          Button('default')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！'
              })
            })
          Button('TopStart')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.TopStart
              })
            })
          Button('Top')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.Top
              })
            })
          Button('TopEnd')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.TopEnd
              })
            })
        }.width('100%')
        .margin({ bottom: 10 })
        .justifyContent(FlexAlign.SpaceEvenly)

        Row() {
          Button('Start')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.Start
              })
            })
          Button('Center')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.Center
              })
            })
          Button('End')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.End
              })
            })
          Button('BottomStart')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.BottomStart
              })
            })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 10 })

        Row() {
          Button('Bottom')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.Bottom
              })
            })
          Button('BottomEnd')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.BottomEnd
              })
            })
          Button('3000')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                duration: 3000,
                alignment: Alignment.Bottom
              })
            })
          Button('m:top_most')
            .onClick(() => {
              promptAction.showToast({
                message: '你好啊！',
                alignment: Alignment.Bottom,
                showMode: promptAction.ToastShowMode.TOP_MOST
              })
            })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 10 })

        CommonTitle({ title: 'promptAction.showDialog' })
        Row() {
          Button('NoButton')
            .onClick(() => {
              promptAction.showDialog({
                title: '温馨提示',
                message: '确定退出登录吗？'
              })
            })
          Button('OneButton')
            .onClick(() => {
              promptAction.showDialog({
                title: '温馨提示',
                message: '确定退出登录吗？',
                buttons: [
                  {
                    text: '知道了',
                    color: '#ff0000'
                  }
                ]
              })
            })
          Button('TwoButton')
            .onClick(() => {
              promptAction.showDialog({
                title: '温馨提示',
                message: '确定退出登录吗？',
                buttons: [
                  {
                    text: '取消',
                    color: '#000000'
                  },
                  {
                    text: '确定',
                    color: '#ff0000'
                  }
                ]
              })
            })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 10 })

        Row() {
          Button('NoTitle')
            .onClick(() => {
              promptAction.showDialog({
                message: '确认退出吗？'
              })
            })
          Button('NoMessage')
            .onClick(() => {
              promptAction.showDialog({
                title: '确认退出吗？'
              })
            })
          Button('Callback')
            .onClick(() => {
              promptAction.showDialog({
                title: '温馨提示',
                message: '确认退出吗？',
                buttons: [
                  {
                    text: '取消',
                    color: '#000000'
                  },
                  {
                    text: '确定',
                    color: '#ff0000'
                  }
                ]
              }, (error: BusinessError, data: promptAction.ShowDialogSuccessResponse) => {
                if (error) {
                  ToastUtils.show(error.message)
                  return
                }
                if (data?.index == 0) {
                  ToastUtils.show('取消')
                } else {
                  ToastUtils.show('确定')
                }
              })
            })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 10 })

        CommonTitle({ title: 'UIContext的openCustomDialog' })
        CommonButton({ text: 'uiContext.openCustomDialog' })
          .onClick(() => {
            DialogUtils.show()
          })
        CommonButton({ text: 'uiContext.closeCustomDialog' })
          .onClick(() => {
            DialogUtils.close()
          })

        CommonButton({ text: 'uiContext.getPromptAction().showActionMenu' })
          .onClick(() => {
            this.uiContext.getPromptAction()
              .showActionMenu({
                title: 'ActionMenu',
                buttons: [
                  {
                    text: 'item1',
                    color: '#ff0000'
                  },
                  {
                    text: 'item2',
                    color: '#00ff00'
                  },
                  {
                    text: 'item3',
                    color: '#0000ff'
                  }
                ]
              })
              .then(() => {

              })
              .catch((e: BusinessError) => {

              })
          })
        CommonButton({ text: 'uiContext.getPromptAction().showDialog' })
          .onClick(() => {
            this.uiContext.getPromptAction()
              .showDialog({
                title: 'showActionMenu',
                message: '这是Message啊啊啊啊啊',
                buttons: [
                  {
                    text: 'item1',
                    color: '#ff0000'
                  },
                  {
                    text: 'item2',
                    color: '#00ff00'
                  },
                  {
                    text: 'item3',
                    color: '#0000ff'
                  }
                ]
              })
              .then(() => {

              })
              .catch((e: BusinessError) => {

              })
          })
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
        CommonTitle({ title: '菜单' })
        //普通菜单
        CommonButton({ text: '普通菜单:bindMenu' })
          .onClick(() => {
            this.isShowMenu = !this.isShowMenu
          })
          .bindMenu(//是个数组
            [
              {
                value: '菜单Item1',
                action: () => {
                  promptAction.showToast({ message: '菜单Item1', duration: 2000 })
                }
              },
              {
                value: '菜单Item2',
                action: () => {
                  promptAction.showToast({ message: '菜单Item2', duration: 2000 })
                }
              },
              {
                value: '菜单Item3',
                action: () => {
                  promptAction.showToast({ message: '菜单Item3', duration: 2000 })
                }
              },
              {
                value: '菜单Item4',
                action: () => {
                  promptAction.showToast({ message: '菜单Item4', duration: 2000 })
                }
              },
              {
                value: '菜单Item5',
                action: () => {
                  promptAction.showToast({ message: '菜单Item5', duration: 2000 })
                }
              }
            ], { title: '请选择' }
          )
        CommonButton({ text: '自定义菜单:bindMenu' })
          .bindMenu(this.myMenu)
        CommonButton({ text: '设置弹出方式：bindContextMenu长按' })
        //hapticFeedbackMode:HapticFeedbackMode.ENABLED 弹出菜单增加震动效果  Api18
          .bindContextMenu(this.myMenu, ResponseType.LongPress/*,{hapticFeedbackMode:HapticFeedbackMode.ENABLED}*/)

        CommonTitle({ title: '弹窗：AlertDialog' })
        //AlertDialog
        CommonButton({ text: 'AlertDialogParamWithConfirm' })
          .onClick(() => {
            this.uiContext.showAlertDialog(
              {
                // title: '',
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
                },
                onWillDismiss: () => {

                }
              }
            )
          })
        CommonButton({ text: 'AlertDialogParamWithButtons' })
          .onClick(() => {
            this.uiContext.showAlertDialog(
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
              transition:
              TransitionEffect.asymmetric(TransitionEffect.OPACITY
                .animation({ duration: 800, curve: Curve.Sharp })
                .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 })
                  .animation({ duration: 800, curve: Curve.Sharp })),
                TransitionEffect.OPACITY
                  .animation({ duration: 800, curve: Curve.Smooth })
                  .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 })
                    .animation({ duration: 800, curve: Curve.Smooth }))),
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

        CommonTitle({ title: '高级组件-弹窗' })
        CommonButton({ text: 'TipDialog' })
          .onClick(() => {
            this.tipDialogController.open()
          })
        CommonButton({ text: 'SelectDialog' })
          .onClick(() => {
            this.selectDialogController.open()
          })
        CommonButton({ text: 'ConfirmDialog' })
          .onClick(() => {
            this.confirmDialogController.open()
          })
        CommonButton({ text: 'AlertDialog' })
          .onClick(() => {
            this.alertDialogController.open()
          })
        CommonButton({ text: 'LoadingDialog' })
          .onClick(() => {
            this.loadingDialogController.open()
          })
        CommonTitle({ title: '选择器' })
        CommonButton({ text: 'CalendarPickerDialog' })
          .onClick(() => {
            CalendarPickerDialog.show({
              selected: new Date(2025, 6, 20), //已选择日期
              acceptButtonStyle: {
                //确认按钮样式
                fontSize: 18,
                fontColor: Color.Green,
                fontWeight: FontWeight.Bold,
                backgroundColor: Color.Yellow,
                borderRadius: 10,
                type: ButtonType.Capsule
              },
              cancelButtonStyle: {
                //取消按钮样式
                fontSize: 18,
                fontColor: Color.Black,
                fontWeight: FontWeight.Bold,
                backgroundColor: Color.Gray,
                borderRadius: 10,
                type: ButtonType.Capsule
              },
              onAccept: (value: Date) => { //确认选择日期回调
                ToastUtils.show(value.toString())
              },
              onCancel: () => { //取消的回调

              },
              onChange: (value: Date) => { //选择切换的回调

              }
            })
          })
        CommonButton({ text: 'DatePickerDialog具体见常用组件-日期时间组件' })
          .onClick(() => {
            DatePickerDialog.show({
              start: new Date(2000, 1, 1),
              end: new Date(2050, 12, 31),
              selected: this.selectedDate,
              lunar: true, //是否显示阴历
              lunarSwitch: true, //是否显示农历阳历切换开关
              showTime: true, //是否显示详细的当天时间
              useMilitaryTime: true, //showTime=true时，是否使用24小时制
              disappearTextStyle: {
                //显示不明显的文本颜色
                color: Color.Green
              },
              textStyle: {
                //显示明显的文本颜色
                color: Color.Orange
              },
              selectedTextStyle: {
                //选中的文字样式
                color: Color.Red
              },
              // acceptButtonStyle:{//确认按钮样式
              //
              // },
              cancelButtonStyle: {
                //取消按钮样式

              },
              onAccept: (value: DatePickerResult) => {
                promptAction.showToast({ message: value.year + '-' + value.month + '-' + value.day })
              },
              onDateAccept: (value: Date) => {
                this.selectedDate = value
              },
              onCancel: () => {

              },
              onChange: (value: DatePickerResult) => {
                console.debug('滑动：' + value.year + '-' + value.month + '-' + value.day)
              }
            })
          })

        CommonButton({ text: 'TimePickerDialog具体见常用组件-日期时间组件' })
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
              canLoop: false,
              onAccept: (value: TextPickerResult) => {

              },
              onCancel: () => {

              },
              onChange: (value: TextPickerResult) => {

              }
            })
          })

        CommonTitle({ title: '模态页面' })
        CommonButton({ text: '半模态页面：bindSheet' })
          .onClick(() => {
            this.isShowSheet = !this.isShowSheet
          })
          .bindSheet(this.isShowSheet, this.SheetBuilderView, {
            title: {
              title: '请选择啊',
              subtitle: '请快点选择啊'
            },
            // height:SheetSize.LARGE,//半模态高度，默认是LARGE。
            // width: 600,//半模态宽度
            borderWidth: 10,
            borderColor: Color.Red,
            borderStyle: BorderStyle.Dashed,
            // blurStyle:BlurStyle.Thick,//模糊背景
            // maskColor:'#80ffffff',//蒙层颜色
            preferType: SheetType.BOTTOM, //半模态页面的样式
            showClose: true, //是否显示关闭按钮
            enableOutsideInteractive: false, //半模态所在页面是否允许交互
            scrollSizeMode: ScrollSizeMode.FOLLOW_DETENT, //设置半模态面板滑动时，内容区域刷新时机。默认FOLLOW_DETENT
            // shouldDismiss: (event) => {
            //   console.debug('===Dismiss')
            // },
            onHeightDidChange: (height: number) => {
              console.debug('===高度：' + height)
            },
            onDetentsDidChange: (value: number) => {
              //半模态却换挡位变化的回调
            },
            onDisappear: () => { //半模态页面回退（动画结束后）回调函数。
              this.isShowSheet = false
            },
            //sheet消失的拦截，可以根据不同的关闭原因拦截
            onWillDismiss: (event: DismissSheetAction) => {
              switch (event.reason) {
                case DismissReason.PRESS_BACK:
                  ToastUtils.show('点击返回按钮关闭')
                  event.dismiss()
                  break
                case DismissReason.TOUCH_OUTSIDE:
                  ToastUtils.show('触摸外部关闭')
                  event.dismiss()
                  break
                case DismissReason.CLOSE_BUTTON:
                  ToastUtils.show('点击关闭按钮关闭')
                  event.dismiss()
                  break
                case DismissReason.SLIDE_DOWN:
                  ToastUtils.show('下滑关闭')
                  event.dismiss()
                  break
              }
            },
            dragBar: true, //是否显示拖拽条
            //sheet展示的高度数组 第一个为默认打开的高度，只能有三个高度，最高、最低、中间
            detents: [SheetSize.MEDIUM, SheetSize.LARGE, 100],
            mode: SheetMode.OVERLAY, //sheet覆盖在页面上还是嵌套在页面中
          })

        CommonButton({ text: '半模态和全模态切换' })
          .onClick(() => {
            BindContentCoverDemo.startPage()
          })

        Image($r('app.media.har_imge'))
          .width(160)
          .height(90)
          .onClick(() => {
            this.isShowBindContentCover = !this.isShowBindContentCover
          })
          .onDisAppear(() => {
            this.isShowBindContentCover = false
          })
          .bindContentCover($$this.isShowBindContentCover, this.ImageContentCover($r('app.media.har_imge'),()=>{
             this.isShowBindContentCover=false
          }),
            {
              transition: TransitionEffect.scale({ x: 0.3, y: 0.3 })
                .combine(TransitionEffect.translate({y:500}))
                .animation({ curve: curves.springMotion(0.6, 0.8) })
            })


      }.width('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
  }

  private testNum: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  @Builder
  SheetBuilderView() {

    Column() {
      List() {
        ForEach(this.testNum, (item: number) => {
          ListItem() {
            Text(`item-${item}`)
              .width('100%')
              .height(45)
              .alignSelf(ItemAlign.Center)
              .fontSize(18)
          }
        })
      }.width('100%')
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST
      })

      // Text('其他内容').width('100%')
      //   .layoutWeight(1)
      //   .alignSelf(ItemAlign.Center)
      //   .backgroundColor(Color.Green)
    }.width('100%')
    .height('100%')
  }

  @Builder
  ImageContentCover(src: ResourceStr, onClickOut: () => void) {
    Stack({ alignContent: Alignment.Center }) {
      Image(src)
        .objectFit(ImageFit.Contain)
        .width('100%')
        .height('100%')
    }.backgroundColor(Color.Black)
    .onClick(() => {
      onClickOut?.()
    })
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
      MenuItem({
        startIcon: $r('app.media.icon_menu'),
        content: '菜单3',
        endIcon: $r('app.media.ic_into'),
        builder: this.SubMenu
      })

      MenuItemGroup({ header: '分组菜单栏Header', footer: '分栏菜单Footer' }) {
        MenuItem({
          startIcon: $r('app.media.icon_menu'),
          content: '分组菜单1', endIcon: $r('app.media.ic_into'),
        })
          .contentFontColor(Color.Red)

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
        .labelFontColor(Color.Green)
      MenuItem({ content: "粘贴", labelInfo: "Ctrl+V" })
        .labelFontColor(Color.Yellow)
    }
  }

  @State isTipDialogChecked: boolean = false
  private tipDialogController: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      imageRes: $r('app.media.img1'),
      imageSize: { width: 160, height: 90 },
      title: '温馨提示',
      content: '您好，确定同意吗？您好，确定同意吗？您好，确定同意吗？您好，确定同意吗？您好，确定同意吗？',
      checkTips: '勾选并同意《隐私协议》',
      isChecked: this.isTipDialogChecked,
      checkAction: (isChecked: boolean) => {
        this.isTipDialogChecked = isChecked
      },
      primaryButton: {
        value: '取消',
        fontColor: '595959',
        buttonStyle: ButtonStyleMode.NORMAL,
        role: ButtonRole.NORMAL,
        background: Color.White,
        action: () => {
          ToastUtils.show('取消')
        }
      },
      secondaryButton: {
        value: '确定',
        fontColor: Color.White,
        buttonStyle: ButtonStyleMode.NORMAL,
        role: ButtonRole.NORMAL,
        background: Color.Red,
        action: () => {
          ToastUtils.show('确定')
        }
      }
    }),
    autoCancel: false
  })
  @State selectDialogIndex: number = 0
  private selectDialogList: SheetInfo[] = [
    {
      icon: $r('app.media.tab_home_t'),
      title: '去西安',
      action: () => {
        this.selectDialogIndex = 0
      }
    },
    {
      icon: $r('app.media.tab_info_t'),
      title: '去大理',
      action: () => {
        this.selectDialogIndex = 1
      }
    }, {
    icon: $r('app.media.tab_my_t'),
    title: '去伊犁',
    action: () => {
      this.selectDialogIndex = 2
    }
  },
  ]
  private selectDialogController: CustomDialogController = new CustomDialogController({
    builder: SelectDialog({
      title: '温馨提示',
      content: '你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好',
      selectedIndex: this.selectDialogIndex,
      confirm: {
        value: '确定',
        fontColor: Color.White,
        background: Color.Red,
        action: () => {
          ToastUtils.show(this.selectDialogList[this.selectDialogIndex].title)
        }
      },
      radioContent: this.selectDialogList
    }),
    autoCancel: false
  })
  private confirmDialogController: CustomDialogController = new CustomDialogController({
    builder: ConfirmDialog({
      title: '温馨提示',
      content: '确定要退出登录？',
      // checkTips: '勾选并同意《隐私协议》',
      // isChecked: this.isTipDialogChecked,
      primaryButton: {
        value: '取消',
        fontColor: '595959',
        buttonStyle: ButtonStyleMode.NORMAL,
        role: ButtonRole.NORMAL,
        background: Color.White,
        action: () => {
          ToastUtils.show('取消')
        }
      },
      secondaryButton: {
        value: '确定',
        fontColor: Color.White,
        buttonStyle: ButtonStyleMode.NORMAL,
        role: ButtonRole.NORMAL,
        background: Color.Red,
        action: () => {
          ToastUtils.show('确定')
        }
      }
    })
  })
  private alertDialogController: CustomDialogController = new CustomDialogController({
    builder: AlertDialog({
      primaryTitle: '温馨提示',
      secondaryTitle: '确定要退出登录',
      content: '退出登录用户信息将被清除',
      primaryButton: {
        value: '取消',
        fontColor: '595959',
        buttonStyle: ButtonStyleMode.NORMAL,
        role: ButtonRole.NORMAL,
        background: Color.White,
        action: () => {
          ToastUtils.show('取消')
        }
      },
      secondaryButton: {
        value: '确定',
        fontColor: Color.White,
        buttonStyle: ButtonStyleMode.NORMAL,
        role: ButtonRole.NORMAL,
        background: Color.Red,
        action: () => {
          ToastUtils.show('确定')
        }
      }
    })
  })
  private loadingDialogController: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({
      content: '正在加载中...',
      theme: new CustomThemeImpl(new CustomThemeColors())
    })
  })
}

class CustomThemeImpl implements CustomTheme {
  colors?: CustomColors;

  constructor(colors: CustomColors) {
    this.colors = colors;
  }
}

class CustomThemeColors implements CustomColors {
  fontPrimary = '#ffd0a300';
  iconSecondary = '#ffd000cd';
}

@CustomDialog
struct CustomDialogExample {
  private content: string = ''
  controller: CustomDialogController
  onCancel?: () => void
  onConfirm?: () => void
  private scroller: Scroller = new Scroller()
  @State list: Array<TestBean> = []
  onListItemClick?: (index: number) => void

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
      List({ scroller: this.scroller }) {
        ForEach(this.list, (item: TestBean, index: number) => {
          ListItem() {
            Row() {
              Text(item.name).fontColor(Color.Red)
            }.backgroundColor(item.isSelected ? Color.Orange : Color.Pink)
            .onClick(() => {
              if (this.onListItemClick) {
                this.onListItemClick(index)
              }
            }).width(100)
            .height(40)
          }
        }, (item: TestBean) => JSON.stringify(item))
      }.width('100%')

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
            this.onCancel?.()
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
            this.onConfirm?.()
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

