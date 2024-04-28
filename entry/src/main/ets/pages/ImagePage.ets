import thermal from '@ohos.thermal'
import picker from '@ohos.file.picker'
import { CommonButton, RadioList } from './component/MyComponent'

@Entry
@Component
struct ImagePage {
  private scroller: Scroller = new Scroller()
  @State imageFit: ImageFit = ImageFit.None
  @State imageRenderMode: ImageRenderMode = ImageRenderMode.Original
  @State imageInterpolation: ImageInterpolation = ImageInterpolation.None
  @State objectRepeat: ImageRepeat = ImageRepeat.NoRepeat
  @State animationStatus: AnimationStatus = AnimationStatus.Initial
  @State isReverse: boolean = false
  @State fillMode: FillMode = FillMode.None
  @State playCount: number = -1

  build() {
    Scroll(this.scroller) {
      Column() {
        //引用图片的几种方式
        //1. 本地资源 ets下 images下   Image('images/ic_local_image.jpg')...
        //2.网络图片 需要网络访问权限 Image('https://xxxx')
        //3.Resource  Image($r('app.media.ic_resource_image'))
        //4.rawfile  Image($rawfile('ic_rawfile_image.jpg'))
        Image('https://ts3.cn.mm.bing.net/th?id=OIP-C.2zg2YQ9jHE0Gvd5P2SPpjwHaFj&w=288&h=216&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2')
          .alt($r('app.media.icon'))//加载时显示的占位图，不支持网络图片
          .width(200)
          .height(200)
          .objectFit(this.imageFit)//图片填充效果
          .renderMode(this.imageRenderMode)//设置图片的渲染模式为原色或黑白。默认值：ImageRenderMode.Original
          .objectRepeat(this.objectRepeat)//设置图片的重复排列类型
          .interpolation(this.imageInterpolation)//设置图片的插值效果，即减轻低清晰度图片在放大显示时出现的锯齿问题。默认值：ImageInterpolation.None
          .fitOriginalSize(false)// .sourceSize({ width: 50, height: 50 })
          .syncLoad(false)//设置是否同步加载图片，默认是异步加载。
          .copyOption(CopyOptions.InApp)
          .draggable(true)
          .margin(10)// .overlay('这是网图', { align: Alignment.Center, offset: { x: 0, y: 10 } })
          .onComplete((msg: {
            width: number,
            height: number,
            componentWidth: number,
            componentHeight: number,
            loadingStatus: number
          }) => {
            console.debug('==图片加载完成：' +
              '图片宽：' + msg.width
              + '-图片高：' + msg.height
              + "-组件宽：" + msg.componentWidth
              + '-组件高：' + msg.componentHeight
              + '-状态' + (msg.loadingStatus == 1 ? '图片加载成功' : '图片解码成功'))
          })
          .onError((msg: {
            componentWidth: number,
            componentHeight: number,
            error: string
          }) => {
            console.debug('==图片加载失败' +
              +"-组件宽：" + msg.componentWidth
              + '-组件高：' + msg.componentHeight
              + '-加载失败信息：' + msg.error)
          })
          .onFinish(() => {
            console.debug('==onFinish')
          })
        RadioList({
          title: '  ImageFit',
          checkedIndex: 0,
          radioGroup: 'ImageFit',
          data: ['None', 'Contain', 'Cover', 'Auto', 'Fill', 'ScaleDown'],
          onCheckChange: (position: number, isChecked: boolean) => {
            if (position == 0 && isChecked) {
              this.imageFit = ImageFit.None
            }
            if (position == 1 && isChecked) {
              this.imageFit = ImageFit.Contain
            }
            if (position == 2 && isChecked) {
              this.imageFit = ImageFit.Cover
            }
            if (position == 3 && isChecked) {
              this.imageFit = ImageFit.Auto
            }
            if (position == 4 && isChecked) {
              this.imageFit = ImageFit.Fill
            }
            if (position == 5 && isChecked) {
              this.imageFit = ImageFit.ScaleDown
            }
          }
        })
        RadioList({
          title: '  ImageRenderMode：',
          checkedIndex: 0,
          radioGroup: 'ImageRenderMode',
          data: ['Original', 'Template'],
          onCheckChange: (position: number, isChecked: boolean) => {
            if (position == 0 && isChecked) {
              this.imageRenderMode = ImageRenderMode.Original
            }
            if (position == 1 && isChecked) {
              this.imageRenderMode = ImageRenderMode.Template
            }
          }
        })
        RadioList({
          title: '  ImageRepeat',
          radioGroup: 'ImageRepeat',
          checkedIndex: 0,
          data: ['NoRepeat', 'X', 'Y', 'XY'],
          onCheckChange: (position: number, isChecked: boolean) => {
            if (position == 0 && isChecked) {
              this.objectRepeat = ImageRepeat.NoRepeat
            }
            if (position == 1 && isChecked) {
              this.objectRepeat = ImageRepeat.X
            }
            if (position == 2 && isChecked) {
              this.objectRepeat = ImageRepeat.Y
            }
            if (position == 3 && isChecked) {
              this.objectRepeat = ImageRepeat.XY
            }
          }
        })
        RadioList({
          title: '  ImageInterpolation',
          radioGroup: 'ImageInterpolation',
          checkedIndex: 0,
          data: ['None', 'Low', 'Medium', 'High'],
          onCheckChange: (position: number, isChecked: boolean) => {
            if (position == 0 && isChecked) {
              this.imageInterpolation = ImageInterpolation.None
            }
            if (position == 1 && isChecked) {
              this.imageInterpolation = ImageInterpolation.Low
            }
            if (position == 2 && isChecked) {
              this.imageInterpolation = ImageInterpolation.Medium
            }
            if (position == 3 && isChecked) {
              this.imageInterpolation = ImageInterpolation.High
            }
          }
        })

        ImageAnimator()
          .images([
            {
              src: $r('app.media.img1')
            },
            {
              src: $r('app.media.img2')
            },
            {
              src: $r('app.media.img3')
            }
          ])
          .width(200)
          .height(100)
          .state(this.animationStatus)
          .duration(2000)
          .reverse(this.isReverse)
          .fixedSize(true)
          .fillMode(this.fillMode)
          .iterations(this.playCount)
          .borderStyle(BorderStyle.Solid)
          .borderWidth(2)
          .borderColor(Color.Red)
          .borderRadius(10)
          .onStart(() => {

          })
          .onPause(() => {

          })
          .onRepeat(() => {

          })
          .onCancel(() => {

          })
          .onFinish(() => {

          })
        Row() {
          Button('Start')
            .onClick(() => {
              this.animationStatus = AnimationStatus.Running
            })
          Button('Pause')
            .onClick(() => {
              this.animationStatus = AnimationStatus.Paused
            }).margin({ left: 5 })
          Button('Stop')
            .onClick(() => {
              this.animationStatus = AnimationStatus.Stopped
            }).margin({ left: 5 })

        }.margin({ top: 10 }).justifyContent(FlexAlign.SpaceEvenly)

        Row() {
          Button('IsReverse')
            .onClick(() => {
              this.isReverse = !this.isReverse
            })
          Button('播放一次')
            .onClick(() => {
              this.playCount = 1
            }).margin({ left: 5 })
          Button('无限播放')
            .onClick(() => {
              this.playCount = -1
            }).margin({ left: 5 })
        }.margin({ top: 10 }).justifyContent(FlexAlign.SpaceEvenly)


        CommonButton({ text: '打开相册' })
          .onClick(() => {
            this.getAllImg()
          })
        Grid() {
          ForEach(this.imgDatas, (item) => {
            GridItem() {
              Image(item)
            }.width(80)
            .height(80)
          }, item => JSON.stringify(item))
        }.columnsGap(8)
        .rowsGap(8)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
    }.width('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)

  }

  @State imgDatas: string[] = [];

  // 获取照片url集
  getAllImg() {

    let result = new Array<string>();
    try {
      let PhotoSelectOptions = new picker.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 5;
      let photoPicker = new picker.PhotoViewPicker();
      photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult) => {
        this.imgDatas = PhotoSelectResult.photoUris;
        console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' + JSON.stringify(PhotoSelectResult));
      }).catch((err) => {
        console.error(`PhotoViewPicker.select failed with. Code: ${err.code}, message: ${err.message}`);
      });
    } catch (err) {
      console.error(`PhotoViewPicker failed with. Code: ${err.code}, message: ${err.message}`);
    }
  }
}