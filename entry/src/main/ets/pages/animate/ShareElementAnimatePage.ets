import { RouterUtil } from "@ohos/common";

class InfoBean {
  avatar: ResourceStr = ''
  name: string = ''
  message: string = ''
  images: ResourceStr[] = []
}

@Entry({ routeName: 'ShareElementAnimatePage' })
@Component
export struct ShareElementAnimatePage {
  static startPage() {
    RouterUtil.pushNamedRoute('ShareElementAnimatePage')
  }

  private infosList: InfoBean[] = [
    {
      name: '海阔天空',
      message: '今天的天气真好~',
      avatar: $r('app.media.app_icon'),
      images: [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]
    },
    {
      name: '岁月静好',
      message: '今天的天气真好~',
      avatar: $r('app.media.app_icon'),
      images: [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]
    },
    {
      name: '相信一切',
      message: '今天的天气真好~',
      avatar: $r('app.media.app_icon'),
      images: [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]
    },
    {
      name: '花开富贵',
      message: '今天的天气真好~',
      avatar: $r('app.media.app_icon'),
      images: [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]
    },
  ]
  @State isExpand: boolean = false
  @State @Watch('onItemClicked') clickIndex: number = 0

  //监听点击条目
  onItemClicked() {
    if (this.clickIndex < 0) {
      return;
    }
    this.getUIContext()?.animateTo({
      duration: 350,
      curve: Curve.Friction
    }, () => {
      this.isExpand = !this.isExpand;
    });
  }

  scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column({ space: 20 }) {
        ForEach(this.infosList, (postData: InfoBean, index: number) => {
          // 当点击了某个post后，会使其余的post消失下树
          if (!this.isExpand || this.clickIndex === index) {
            Column() {
              Post({ data: postData, selectedIndex: this.clickIndex, index: index })
            }
            .width('100%')
            // 对出现消失的post添加透明度转场和位移转场效果
            .transition(TransitionEffect.OPACITY
              .combine(TransitionEffect.translate({ y: index < this.clickIndex ? -250 : 250 }))
              .animation({ duration: 350, curve: Curve.Friction }))
          }
        }, (postData: InfoBean, index: number) => index.toString())
      }
      .size({ width: '100%'})
      .backgroundColor('#40808080')
    }.width('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
  }
}

@Component
struct Post {
  @Link selectedIndex: number;
  @Prop data: InfoBean;
  @Prop index: number;
  @State itemHeight: number = 250;
  @State isExpand: boolean = false;
  @State expandImageSize: number = 100;
  @State avatarSize: number = 50;

  build() {
    Column({ space: 20 }) {
      Row({ space: 10 }) {
        Image(this.data.avatar)
          .size({ width: this.avatarSize, height: this.avatarSize })
          .borderRadius(this.avatarSize / 2)
          .clip(true)

        Text(this.data.name)
      }
      .justifyContent(FlexAlign.Start)

      Text(this.data.message)

      Row({ space: 15 }) {
        ForEach(this.data.images, (imageResource: ResourceStr, index: number) => {
          Image(imageResource)
            .size({ width: this.expandImageSize, height: this.expandImageSize })
        }, (imageResource: ResourceStr, index: number) => index.toString())
      }

      // 展开态下组件增加的内容
      if (this.isExpand) {
        Column() {
          Text('评论区')
          // 对评论区文本添加出现消失转场效果
            .transition(TransitionEffect.OPACITY
              .animation({ duration: 350, curve: Curve.Friction }))
            .padding({ top: 10 })
        }
        .transition(TransitionEffect.asymmetric(
          TransitionEffect.opacity(0.99)
            .animation({ duration: 350, curve: Curve.Friction }),
          TransitionEffect.OPACITY.animation({ duration: 0 })
        ))
        .size({ width: '100%' })
      }
    }
    .backgroundColor(Color.White)
    .size({ width: '100%', height: this.itemHeight })
    .alignItems(HorizontalAlign.Start)
    .padding({ left: 10, top: 10 })
    .onClick(() => {
      this.selectedIndex = -1;
      this.selectedIndex = this.index;
      this.getUIContext()?.animateTo({
        duration: 350,
        curve: Curve.Friction
      }, () => {
        // 对展开的post做宽高动画，并对头像尺寸和图片尺寸加动画
        this.isExpand = !this.isExpand;
        this.itemHeight = this.isExpand ? 780 : 250;
        this.avatarSize = this.isExpand ? 75 : 50;
        this.expandImageSize = (this.isExpand && this.data.images.length > 0)
          ? (360 - (this.data.images.length + 1) * 15) / this.data.images.length : 100;
      })
    })
  }
}