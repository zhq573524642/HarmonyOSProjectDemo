import { curves } from '@kit.ArkUI'
import { CommonTitle } from '../component/MyComponent'

const ITEM_COUNTS = 9;
const ITEM_COLOR = Color.Pink;
const INTERVAL = 30;
const DURATION = 300;

class BindMenuBean {
  title: ResourceStr = ''
  onClickAction: () => void = () => {
  }
}

@Entry
@Component
struct TransitionEffectPage {
  private scroller: Scroller = new Scroller()
  @State isShow: boolean = true
  @State isBindContentCover: boolean = false
  @State isBindSheetShow: boolean = false
  @State isBindMenuShow: boolean = false
  // 第一步，创建TransitionEffect
  private effect: TransitionEffect =
    // 创建默认透明度转场效果,并指定了springMotion(0.6, 0.8)曲线
    TransitionEffect.OPACITY.animation({
      curve: curves.springMotion(0.6, 0.8)
    })// 通过combine方法,这里的动画参数会跟随上面的TransitionEffect，也就是springMotion(0.6, 0.8)
      //出现时：scale:1.5->1,消失时：scale:1->0.2
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.scale({
          x: 1.5,
          y: 1.5
        }),
        TransitionEffect.scale({
          x: 0.2,
          y: 0.2
        })
      ))// 添加旋转转场效果，这里的动画参数会跟随上面带animation的TransitionEffect，也就是springMotion(0.6, 0.8)
        //出现时：rotate:90->0,消失时：rotate:0->90
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.rotate({ angle: 90 }),
        TransitionEffect.rotate({ angle: 90 })
      ))// 添加平移转场效果，这里的动画参数使用指定的springMotion()
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.translate({ y: -150, x: -150 })
          .animation({ curve: curves.springMotion() }),
        TransitionEffect.translate({ y: 150, x: 150 })
          .animation({ curve: curves.springMotion() })
      ))// 添加move转场效果，这里的动画参数会跟随上面的TransitionEffect，也就是springMotion()
        //出现时：opacity:1->0,消失时：opacity:1->0.2
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.opacity(0.2),
        TransitionEffect.opacity(0.2)
      ))
      .combine(TransitionEffect.asymmetric(
        TransitionEffect.move(TransitionEdge.START), TransitionEffect.move(TransitionEdge.END)
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
      Column() {
        CommonTitle({ title: '出现/消失转场' })
        Button('开始动画')
          .onClick(() => {
            this.isShow = !this.isShow
          })
        Stack() {
          if (this.isShow) {
            Column() {
              Text('测试').fontColor(Color.White).fontSize(15)
            }
            .width(150)
            .height(150)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(Color.Red)
            .borderRadius(20)
            .margin(20)
            .transition(this.effect)
          }
        }
        .size({ width: 160, height: 160 })
        .alignContent(Alignment.Center)
        .borderWidth(5)
        .borderColor(Color.Yellow)

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
          animateTo({
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
              this.isBindContentCover = !this.isBindContentCover
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
            dragBar: false, //是否显示控制条
            // blurStyle: BlurStyle.Regular, //模糊背景样式
            maskColor: '#80ffffff', //背景蒙层颜色
            // title: { title: '测试标题', subtitle: '测试副标题' },
            // preferType:SheetType.CENTER,
            shouldDismiss: (sheetDismiss: SheetDismiss) => {
              sheetDismiss.dismiss()
            },
            enableOutsideInteractive: false, //所在页面是否允许交互
            onAppear: () => {

            },
            onDisappear: () => {

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
            title: '菜单'
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
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .transition(TransitionEffect.translate({ y: 500 }).animation({ curve: curves.springMotion(0.6, 0.8) }))
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
    .borderColor(Color.Green)
    .borderWidth(3)
    .borderRadius(5)
  }
}