import { textRecognition } from '@kit.CoreVisionKit';
import { fileIo, picker } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { image } from '@kit.ImageKit';

@Entry
@Component
struct TextRecognitionPage {
  private imageSource: image.ImageSource | undefined = undefined;
  @State chooseImage: PixelMap | undefined = undefined;
  @State dataValues: string = '';

  build() {

    Column() {
      Image(this.chooseImage)
        .width(200)
        .margin(20)
        .height(200)
      Text(this.dataValues)
        .margin(10)
        .fontSize(15)

      Button('选择图片')
        .onClick(() => {
          this.selectImage()
        })
      Button('开始识别')
        .onClick(async () => {
          this.textRecognitionTest()
        })
        .margin(10)
    }
    .width('100%')

  }

  private async textRecognitionTest() {
    if (!this.chooseImage) {
      return;
    }
    // 调用文本识别接口
    let visionInfo: textRecognition.VisionInfo = {
      pixelMap: this.chooseImage
    };
    let textConfiguration: textRecognition.TextRecognitionConfiguration = {
      isDirectionDetectionSupported: false
    };
    textRecognition.recognizeText(visionInfo, textConfiguration, (error: BusinessError, data: textRecognition.TextRecognitionResult) => {
      if (error.code !== 0) {
        hilog.error(0x0000, 'OCRDemo', `Failed to recognize text. Code: ${error.code}, message: ${error.message}`);
        return;
      }
      // 识别成功，获取对应的结果
      let recognitionString = JSON.stringify(data);
      hilog.info(0x0000, 'OCRDemo', `Succeeded in recognizing text：${recognitionString}`);
      // 将结果更新到Text中显示
      this.dataValues = data.value;
      if (this.chooseImage && this.imageSource) {
        this.chooseImage.release();
        this.imageSource.release();
      }
    });
  }

  private async selectImage() {
    let uri = await this.openPhoto();
    if (uri === undefined) {
      hilog.error(0x0000, 'OCRDemo', "Failed to get uri.");
      return;
    }
    this.loadImage(uri);
  }

  private openPhoto(): Promise<string> {
    return new Promise<string>((resolve, reject) => {
      let photoPicker = new picker.PhotoViewPicker();
      photoPicker.select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: 1
      }).then((res: picker.PhotoSelectResult) => {
        resolve(res.photoUris[0]);
      }).catch((err: BusinessError) => {
        hilog.error(0x0000, 'OCRDemo', `Failed to get photo image uri. Code：${err.code}，message：${err.message}`);
        resolve('');
      })
    })
  }

  private loadImage(name: string) {
    setTimeout(async () => {
      let fileSource = await fileIo.open(name, fileIo.OpenMode.READ_ONLY);
      this.imageSource = image.createImageSource(fileSource.fd);
      this.chooseImage = await this.imageSource.createPixelMap();
    }, 100)
  }
}