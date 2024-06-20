import { BusinessError } from '@kit.BasicServicesKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { image } from '@kit.ImageKit'
import { fileIo, picker } from '@kit.CoreFileKit'
// import { faceDetector } from '@kit.CoreVisionKit';

@Entry
@Component
struct FaceDetectorPage {
  @State chooseImage: PixelMap | undefined = undefined
  @State dataValues: string = ''

  build() {
    Column() {
      Image(this.chooseImage)
        .objectFit(ImageFit.Fill)
        .height('60%')
      Text(this.dataValues)
        .copyOption(CopyOptions.LocalDevice)
        .height('15%')
        .margin(10)
        .width('60%')
      Button('选择图片')
        .type(ButtonType.Capsule)
        .fontColor(Color.White)
        .alignSelf(ItemAlign.Center)
        .width('80%')
        .margin(10)
        .onClick(() => {
          // 拉起图库
          this.selectImage()
        })
      Button('人脸检测')
        .type(ButtonType.Capsule)
        .fontColor(Color.White)
        .alignSelf(ItemAlign.Center)
        .width('80%')
        .margin(10)
        .onClick(async () => {
          if(!this.chooseImage) {
            hilog.error(0x0000, 'testTag', "Failed to detect face.");
            return;
          }
          // 调用人脸检测接口
          // let visionInfo: faceDetector.VisionInfo = {
          //   pixelMap: this.chooseImage,
          // };
          // let data:faceDetector.Face[] = await faceDetector.detect(visionInfo);
          // if (data.length === 0) {
          //   this.dataValues = "No face is detected in the image. Select an image that contains a face.";
          // } else {
          //   let faceString = JSON.stringify(data);
          //   hilog.info(0x0000, 'testTag', "faceString data is " + faceString);
          //   this.dataValues = faceString;
          // }
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  private async selectImage() {
    let uri = await this.openPhoto()
    if (uri === undefined) {
      hilog.error(0x0000, 'faceDetectorSample', "Failed to get uri.");
    }
    this.loadImage(uri);
  }

  private openPhoto(): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      let photoPicker = new picker.PhotoViewPicker()
      photoPicker.select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: 1
      }).then(res => {
        resolve(res.photoUris[0])
      }).catch((err: BusinessError) => {
        hilog.error(0x0000, 'faceDetector', `Failed to get photo image uri.code：${err.code}，message：${err.message}`);
        resolve('');
      })
    })
  }

  private loadImage(name: string) {
    setTimeout(async () => {
      let imageSource: image.ImageSource | undefined = undefined;
      let fileSource = await fileIo.open(name, fileIo.OpenMode.READ_ONLY);
      imageSource = image.createImageSource(fileSource.fd);
      this.chooseImage = await imageSource.createPixelMap();
      this.dataValues = "";
      hilog.info(0x0000, 'faceDetectorSample', 'this.chooseImage:', this.chooseImage);
    }, 100
    )
  }
}