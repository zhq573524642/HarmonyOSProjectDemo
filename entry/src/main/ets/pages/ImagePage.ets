import thermal from '@ohos.thermal'
import picker from '@ohos.file.picker'
import { CommonButton } from './component/MyComponent'

@Entry
@Component
struct ImagePage {
  private scroller: Scroller = new Scroller()
  @State imageFit: ImageFit = ImageFit.None
  @State imageFitDesc: string = 'None'

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '切换图片缩放类型' })
          .onClick(() => {
            if (this.imageFit == ImageFit.None) {
              this.imageFit = ImageFit.Contain
              this.imageFitDesc = 'Contain'
            } else if (this.imageFit == ImageFit.Contain) {
              this.imageFit = ImageFit.Cover
              this.imageFitDesc = 'Cover'
            } else if (this.imageFit == ImageFit.Cover) {
              this.imageFit = ImageFit.Auto
              this.imageFitDesc = 'Auto'
            } else if (this.imageFit == ImageFit.Auto) {
              this.imageFit = ImageFit.Fill
              this.imageFitDesc = 'Fill'
            } else if (this.imageFit == ImageFit.Fill) {
              this.imageFit = ImageFit.ScaleDown
              this.imageFitDesc = 'ScaleDown'
            } else if (this.imageFit==ImageFit.ScaleDown) {
              this.imageFit = ImageFit.None
              this.imageFitDesc = 'None'
            }
          })
        Row() {
          //本地资源 ets下 images下
          Image('images/ic_local_image.jpg')
            .margin(8)
            .width(160)
            .height(90)
            .objectFit(this.imageFit)
            .overlay(this.imageFitDesc, { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
            .border({ width: 1 })
          //网络图片 需要网络访问权限
          Image('https://ts3.cn.mm.bing.net/th?id=OIP-C.2zg2YQ9jHE0Gvd5P2SPpjwHaFj&w=288&h=216&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2')
            .width(160)
            .height(90)
            .margin(8)
            .objectFit(this.imageFit)
            .overlay(this.imageFitDesc, { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
            .border({ width: 1 })
        }.width('100%')

        Row() {
          //Resource
          Image($r('app.media.ic_resource_image'))
            .width(160)
            .height(90)
            .border({ width: 1 })
            .margin(8)
            .objectFit(this.imageFit)
            .overlay(this.imageFitDesc, { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
          //rawfile
          Image($rawfile('ic_rawfile_image.jpg'))
            .margin(8)
            .width(160)
            .height(90)
            .border({ width: 1 })
            .objectFit(this.imageFit)
            .overlay(this.imageFitDesc, { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
        }.width('100%')

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