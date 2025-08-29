import { curves } from '@kit.ArkUI'
import { RouterUtil } from '@ohos/common';
import { CommonButton, CommonTitle } from '../component/MyComponent'
import { ShareElementAnimatePage } from './ShareElementAnimatePage';
import { ShareElementByStackPage } from './ShareElementByStackPage';

const ITEM_COUNTS = 9;
const ITEM_COLOR = Color.Pink;
const INTERVAL = 80;
const DURATION = 300;

class BindMenuBean {
  title: ResourceStr = ''
  onClickAction: () => void = () => {
  }
}

@Entry({ routeName: 'TransitionEffectPage' })
@Component
export struct TransitionEffectPage {
  static startPage() {
    RouterUtil.pushNamedRoute('TransitionEffectPage')
  }

  private scroller: Scroller = new Scroller()
  @State isShow: boolean = true
  @State isBindContentCover: boolean = false
  @State isBindSheetShow: boolean = false
  @State isBindMenuShow: boolean = false
  @State isBindPopupShow: boolean = false
  //禁用转场动画
  private effectIdentity: TransitionEffect = TransitionEffect.IDENTITY
  //一、默认封装的好的：OPACITY（出现0->1,小时1->0）、SLIDE（出现从左划入，消失从右划出）
  private effectOPACITY: TransitionEffect =
    //（1）创建默认透明度转场效果,并指定了springMotion(0.6, 0.8)曲线
    TransitionEffect.OPACITY.animation({
      curve: curves.springMotion(0.6, 0.8),
    })
  private effectSLIDE: TransitionEffect =
    //（2）创建默认位移转场效果,并指定了springMotion(0.6, 0.8)曲线
    TransitionEffect.SLIDE.animation({
      curve: curves.springMotion(0.6, 0.8)
    })
  //（3）TransitionEffect.asymmetric创建自定义数值的进入和退出转场效果
  //TransitionEffect.asymmetric：指定非对称的转场效果。
  //第一个参数指定出现的转场效果，第二个参数指定消失的转场效果。
  private effectAsymmetricScale: TransitionEffect =
    //scale:出现时为scale接口设置的值到默认值1，消失时为默认值1到scale接口设置的值。
    //translate:出现时为translate接口设置的值到默认值0，消失时为默认值0到translate接口设置的值。
    //rotate:出现时为rotate接口设置的值到默认值0，消失时为默认值0到rotate接口设置的值。
    //opacity:出现时为opacity设置的值到默认透明度1，消失时为默认透明度1到opacity设置的值。
    TransitionEffect.asymmetric(
      TransitionEffect.scale({
        x: 1.5,
        y: 1.5,
        centerX: '20%', //默认'50%'即中心点，(0,0)代表左上角
        centerY: '20%'
      }),
      TransitionEffect.scale({
        x: 1.5,
        y: 1.5,
        centerX: '20%', //默认'50%'即中心点，(0,0)代表左上角
        centerY: '20%'
      })
    ).animation({
      curve: curves.springMotion(0.6, 0.8)
    })
  // .combine(TransitionEffect.asymmetric(
  //   TransitionEffect.move(TransitionEdge.START), TransitionEffect.move(TransitionEdge.END)
  // ))
  private effectAsymmetricRotate: TransitionEffect =
    TransitionEffect.asymmetric(
      TransitionEffect.rotate({
        angle: 180
      }),
      TransitionEffect.rotate({
        angle: 180
      })
    ).animation({ curve: curves.springMotion(0.6, 0.8) })
  private effectAsymmetricTranslate: TransitionEffect =
    TransitionEffect.asymmetric(
      TransitionEffect.translate({
        x: -100,
        y: 100
      }),
      TransitionEffect.translate({
        x: 100,
        y: 100
      })
    ).animation({ curve: curves.springMotion(0.6, 0.8) })
  private effectAsymmetricOpacity: TransitionEffect =
    TransitionEffect.asymmetric(
      TransitionEffect.opacity(1.0),
      TransitionEffect.opacity(0)
    ).animation({ curve: curves.springMotion(0.6, 0.8) })
  private effectAsymmetricMove: TransitionEffect =
    TransitionEffect.asymmetric(
      //从窗口的边缘
      TransitionEffect.move(TransitionEdge.TOP), TransitionEffect.move(TransitionEdge.BOTTOM)
    ).animation({ curve: curves.springMotion(0.6, 0.8) })
  private effectAsymmetricCombine: TransitionEffect =
    TransitionEffect.asymmetric(
      TransitionEffect.opacity(1.0),
      TransitionEffect.opacity(0)
    ).animation({ curve: curves.springMotion(0.6, 0.8) })
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.translate({
          x: -100,
          y: 100
        }),
        TransitionEffect.translate({
          x: 100,
          y: 100
        })
      ))
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.rotate({
          angle: 180
        }),
        TransitionEffect.rotate({
          angle: 180
        })
      ))
  @State isGridShow: boolean = false;
  private dataArray: number[] = new Array(ITEM_COUNTS);
  @State bindMenuArray: MenuElement[] = [
    {
      value: '首页',
      action: () => {

      }
    },
    {
      value: '项目',
      action: () => {

      }
    },
    {
      value: '我的',
      action: () => {

      }
    }
  ]

  aboutToAppear(): void {
    for (let i = 0; i < ITEM_COUNTS; i++) {
      this.dataArray[i] = i;
    }
  }

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        CommonTitle({ title: '出现/消失转场' })
        CommonTitle({ title: '1.IDENTITY禁用转场动画', fontSize: 14 })
        AnimateTestStack({ effect: this.effectIdentity })
        CommonTitle({ title: '2.OPACITY默认透明度转场', fontSize: 14 })
        AnimateTestStack({ effect: this.effectOPACITY })
        CommonTitle({ title: '3.SLIDE默认平移转场', fontSize: 14 })
        AnimateTestStack({ effect: this.effectSLIDE })
        CommonTitle({ title: '4.TransitionEffect.asymmetric构建进入和退出:', fontSize: 14 })
        AnimateTestStack({ title: 'scale', effect: this.effectAsymmetricScale })
        AnimateTestStack({ title: 'rotate', effect: this.effectAsymmetricRotate })
        AnimateTestStack({ title: 'translate', effect: this.effectAsymmetricTranslate })
        AnimateTestStack({ title: 'opacity', effect: this.effectAsymmetricOpacity })
        AnimateTestStack({ title: 'move', effect: this.effectAsymmetricMove })
        CommonTitle({ title: '4.TransitionEffect.asymmetric和combine组合构建进入和退出:', fontSize: 14 })
        AnimateTestStack({ title: '组合', effect: this.effectAsymmetricCombine })
        Stack() {
          if (this.isGridShow) {
            Grid() {
              ForEach(this.dataArray, (item: number, index: number) => {
                GridItem() {
                  Stack() {
                    Text((item + 1).toString())
                  }
                  .size({ width: 50, height: 50 })
                  .backgroundColor(ITEM_COLOR)
                  .transition(TransitionEffect.OPACITY
                    .combine(TransitionEffect.rotate({ angle: 360 }))
                    .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 }))// 对每个方格的转场添加delay，实现组件的渐次出现消失效果
                    .animation({ duration: DURATION, curve: Curve.Friction, delay: INTERVAL * index }))
                  .borderRadius(10)
                }
                // 消失时，如果不对方格的所有父控件添加转场效果，则方格的消失转场不会生效
                // 此处让方格的父控件在出现消失转场时一直以0.99的透明度显示，使得方格的转场效果不受影响
                .transition(TransitionEffect.opacity(0.99))
              }, (item: number) => item.toString())
            }
            .columnsTemplate('1fr 1fr 1fr')
            .rowsGap(15)
            .columnsGap(15)
            .size({ width: 180, height: 180 })
            // 消失时，如果不对方格的所有父控件添加转场效果，则方格的消失转场不会生效
            // 此处让父控件在出现消失转场时一直以0.99的透明度显示，使得方格的转场效果不受影响
            .transition(TransitionEffect.opacity(0.99))
          }
          Text('点击').fontColor(Color.Black).fontSize(15)
        }
        .margin(10)
        .size({ width: 200, height: 200 })
        .alignContent(Alignment.Center)
        .borderWidth(5)
        .borderColor(Color.Green)
        .onClick(() => {
          this.getUIContext().animateTo({
            duration: DURATION + INTERVAL * (ITEM_COUNTS - 1),
            curve: Curve.Friction
          }, () => {
            this.isGridShow = !this.isGridShow;
          })
        })

        CommonTitle({ title: '导航转场' })
        CommonTitle({ title: '模态转场' })
        Button('使用bindContentCover构建全屏模态转场效果')
          .margin(10)
          .bindContentCover(this.isBindContentCover, this.MyFullScreenView(), {
            modalTransition: ModalTransition.NONE,

            onDisappear: () => {
              if (this.isBindContentCover) {
                this.isBindContentCover = !this.isBindContentCover
              }
            },
          })
          .onClick(() => {
            this.isBindContentCover = !this.isBindContentCover
          })

        Button('使用bindSheet构建半模态转场效果')
          .margin(10)
          .bindSheet(this.isBindSheetShow, this.MyBindSheetView(), {
            height: 300,
            // showClose: true,
            detents: [500, 600, 700], //与dragBar搭配使用 半模态页面的切换高度档位
            dragBar: true, //是否显示控制条
            // blurStyle: BlurStyle.Regular, //模糊背景样式
            maskColor: '#80ffffff', //背景蒙层颜色
            // title: { title: '测试标题', subtitle: '测试副标题' },
            // preferType:SheetType.CENTER,
            // shouldDismiss: (sheetDismiss: SheetDismiss) => {
            //   sheetDismiss.dismiss()
            // },
            enableOutsideInteractive: false, //所在页面是否允许交互
            onAppear: () => {

            },
            onDisappear: () => {
              if (this.isBindSheetShow) {
                this.isBindSheetShow = !this.isBindSheetShow
              }
            }
          })
          .onClick(() => {
            this.isBindSheetShow = !this.isBindSheetShow
          })

        Button('使用bindMenu实现菜单弹出效果')
          .margin(10)
          .onClick(() => {
            this.isBindMenuShow = !this.isBindMenuShow
          })
          .bindMenu(this.isBindMenuShow, this.bindMenuArray, {
            title: '菜单',
            onDisappear: () => {
              if (this.isBindMenuShow) {
                this.isBindMenuShow = !this.isBindMenuShow
              }
            }
          })
        Image($r('app.media.img2'))
          .width(100)
          .height(100)
          .margin(10)
          .objectFit(ImageFit.Fill)
          .bindContextMenu(this.MyBindContextMenu(), ResponseType.LongPress, {
            placement: Placement.BottomRight, //优先显示的位置，放不下时自动调整位置
            offset: { x: 0, y: 0 }, //弹出位置的便宜
            enableArrow: true, //是否显示进入的箭头，如果放不下则不显示
            preview: this.MyBindContextMenuPreview(), //预览view
            backgroundColor: Color.Pink
          })
        Image($r('app.media.img1'))
          .width(100)
          .height(100)
          .margin(10)
          .objectFit(ImageFit.Fill)
          .onClick(() => {
            this.isBindPopupShow = !this.isBindPopupShow
          })
          .bindPopup(this.isBindPopupShow, {
            builder: this.MyBindContextMenuPreview(),
            autoCancel: true, //点击外部是否可以取消
            enableArrow: true, //是否显示箭头
            arrowPointPosition: ArrowPointPosition.START, //箭头的位置：start，center，end
            arrowWidth: 50, //箭头的宽
            arrowHeight: 60, //箭头的高
            targetSpace: 10, //popup和点击目标的间距
            // message: 'aaaaaaaa', //如果message不为空就会显示按钮
            // messageOptions: {
            //   textColor: Color.Red
            // },
            followTransformOfTarget: true,
            radius: 10, //popup边框半径
            placement: Placement.Top, //弹出位置
            popupColor: Color.Yellow,
            primaryButton: {
              value: '确定',
              action: () => {

              }
            },
            secondaryButton: {
              value: '取消',
              action: () => {

              }
            },

            onStateChange: (event) => {
              if (!event.isVisible) {
                this.isBindPopupShow = false
              }
            }
          })
        CommonTitle({ title: '共享元素转场' })
        CommonButton({ text: '不新建容器并直接改变原容器' })
          .onClick(() => {
            ShareElementAnimatePage.startPage()
          })

        CommonButton({ text: '新建容器并跨容器迁移组件:结合Stack' })
          .onClick(() => {
            ShareElementByStackPage.startPage()
          })
      }
      .width('100%')
      .backgroundColor('#f5f5f5')
    }.width('100%')
  }

  @Builder
  MyFullScreenView() {
    Column() {
      Text('bindContentCover')
        .fontColor(Color.Blue)
        .fontSize(20)
      Button('关闭')
        .margin(20)
        .onClick(() => {
          this.isBindContentCover = !this.isBindContentCover
        })
    }
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .transition(TransitionEffect.asymmetric(
      TransitionEffect.translate({ x: -500 }),
      TransitionEffect.translate({ x: 500 }))
      .animation({ curve: curves.springMotion(0.6, 0.8) })
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.scale({
          x: 0.5,
          y: 0.5
        }),
        TransitionEffect.scale({
          x: 0.5,
          y: 0.5
        })
      ))
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.opacity(0.3),
        TransitionEffect.opacity(0.3)
      )))
  }

  @Builder
  MyBindSheetView() {
    Column() {
      Text('测试')
        .fontSize(15)
        .fontColor(Color.Blue)
      Button('关闭')
        .margin(10)
        .onClick(() => {
          this.isBindSheetShow = !this.isBindSheetShow
        })
    }
    .width('100%')
    .height('100%')
    // .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .transition(TransitionEffect.asymmetric(
      TransitionEffect.translate({ y: 500 }),
      TransitionEffect.translate({ y: -500 })
    )
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.opacity(0),
        TransitionEffect.opacity(0)
      ))
      .animation({ curve: curves.springMotion(0.6, 0.8) }))
  }

  @Builder
  MyBindContextMenu() {
    Column({ space: 10 }) {
      Text('保存').fontSize(14).fontColor(Color.Black)
        .width(150)
        .height(50)
      Text('分享').fontSize(14).fontColor(Color.Black)
        .width(150)
        .height(50)
      Text('搜索').fontSize(14).fontColor(Color.Black)
        .width(150)
        .height(50)
    }
  }

  @Builder
  MyBindContextMenuPreview() {
    Column() {
      Image($r('app.media.img3')).width(90).height(160)
    }
    .margin(10)
    .borderRadius(5)
  }
}

@Component
struct AnimateTestStack {
  title: string = '测试'
  @State isShow: boolean = true
  effect: TransitionEffect = TransitionEffect.IDENTITY

  build() {
    Stack() {
      if (this.isShow) {
        Column() {
          Text(this.title).fontColor(Color.White).fontSize(15)
        }
        .width(80)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Red)
        .borderRadius(20)
        .margin(20)
        .transition(this.effect)
      }
    }
    .size({ width: 90, height: 90 })
    .alignContent(Alignment.Center)
    .borderWidth(5)
    .borderColor(Color.Yellow)
    .onClick(() => {
      this.isShow = !this.isShow
    })
  }
}