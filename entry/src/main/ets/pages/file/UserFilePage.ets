import { common } from '@kit.AbilityKit'
import { fileIo, fileShare, picker } from '@kit.CoreFileKit'
import { CommonButton, CommonTitle } from '../component/MyComponent'
import { BusinessError } from '@kit.BasicServicesKit'
import { buffer } from '@kit.ArkTS'
import fileIO from '@ohos.fileio'
import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { dataSharePredicates } from '@kit.ArkData'
import { ToastUtils } from '@ohos/common'

@Entry
@Component
struct DocumentPickerPage {
  private context = getContext() as common.UIAbilityContext
  documentPicker = new picker.DocumentViewPicker(this.context)
  documentSelectOptions = new picker.DocumentSelectOptions()
  documentSaveOptions = new picker.DocumentSaveOptions()
  audioPicker = new picker.AudioViewPicker(this.context)
  audioSelectOptions = new picker.AudioSelectOptions()
  audioSaveOptions = new picker.AudioSaveOptions()
  @State content: string = ''
  @State saveContent: string = ''
  @State uriList: Array<string> = []
  @State uriMediaList: Array<string> = []
  @State saveUriList: Array<string> = []
  photoViewPicker = new photoAccessHelper.PhotoViewPicker()
  photoSelectOptions = new photoAccessHelper.PhotoSelectOptions()
  phAccessHelper = photoAccessHelper.getPhotoAccessHelper(this.context);

  aboutToAppear(): void {
    //1.DocumentSelectOptions配置
    this.documentSelectOptions.maxSelectNumber = 5 //选择文档的最大数目
    //// 选择文件的后缀类型['后缀类型描述|后缀类型']（可选）
    // 若选择项存在多个后缀名，则每一个后缀名之间用英文逗号进行分隔（可选），
    // 后缀类型名不能超过100,选择所有文件：'所有文件(*.*)|.*';
    this.documentSelectOptions.fileSuffixFilters = ['图片(.png, .jpg)|.png,.jpg', '文档|.txt', '视频|.mp4', '.pdf']
    //指定选择的文件或者目录路径
    // this.documentSelectOptions.defaultFilePathUri="file://docs/storage/Users/currentUser/test"

    //2.DocumentSaveOptions配置
    this.documentSaveOptions.defaultFilePathUri = "file://docs/storage/Users/currentUser/test";
    this.documentSaveOptions.newFileNames = ["DocumentViewPicker01.txt"]

    //3.PhotoSelectOptions配置
    //选择媒体文件类型和选择媒体文件的最大数目
    this.photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
    this.photoSelectOptions.maxSelectNumber = 5

    //4.AudioSaveOptions配置
    this.audioSaveOptions.newFileNames = ['AudioViewPicker01.mp3'];

  }

  build() {
    Column({ space: 10 }) {
      CommonTitle({ title: '选择用户文件' })
      CommonButton({ text: 'DocumentViewPicker:select' })
        .onClick(() => {
          this.selectDocumentViewPicker()
        })
      CommonButton({ text: 'AudioViewPicker:select' })
        .onClick(() => {
          this.selectAudioViewPicker()
        })
      CommonButton({ text: 'photoViewPicker:select' })
        .onClick(() => {
          this.selectPhotoViewPicker()
        })
      CommonTitle({ title: '保存用户文件' })
      CommonButton({ text: 'DocumentViewPicker:save' })
        .onClick(() => {
          this.saveDocumentViewPicker()
        })
      CommonButton({ text: 'AudioViewPicker:save' })
        .onClick(() => {
          this.saveAudioViewPicker()
        })
      CommonButton({ text: '授权持久化' })
        .onClick(() => {

        })
      CommonButton({ text: '读取选择结果' })
        .onClick(() => {
          if (this.uriList.length > 0) {
            this.uriList.forEach((value: string) => {
              this.readFileContent(value)
            })
          }
        })
      CommonButton({ text: '保存内容' })
        .onClick(() => {
          if (this.saveUriList.length > 0) {
            this.saveUriList.forEach((value: string) => {
              this.writeAndSaveFile(value)
            })
          }
        })
      CommonButton({ text: '读取选择的媒体文件' })
        .onClick(() => {
          if (this.uriMediaList.length > 0) {
            this.uriMediaList.forEach((value: string) => {
              this.readMediaFile(value)
            })
          }
        })
      Text(this.content).fontSize(14)
        .fontColor(Color.Red)
      Text(this.saveContent).fontSize(14)
        .fontColor(Color.Green)
    }
    .height('100%')
    .width('100%')
  }

  selectDocumentViewPicker() {
    this.documentPicker.select(this.documentSelectOptions)
      .then((result: Array<string>) => {
        console.debug('===DocumentViewPicker选择：' + result.toString())
        this.uriList = result
      })
      .catch((error: BusinessError) => {
        console.debug('===异常：' + error.message)
      })
  }

  saveDocumentViewPicker() {
    this.documentPicker.save(this.documentSaveOptions)
      .then((result: Array<string>) => {
        this.saveUriList = result
      })
      .catch((error: BusinessError) => {
        console.debug('===保存异常：' + error.message)
      })
  }

  selectAudioViewPicker() {
    this.audioPicker.select(this.audioSelectOptions)
      .then((result: Array<string>) => {
        console.debug('===AudioViewPicker选择：' + result.toString())
        this.uriList = result
      })
      .catch((error: BusinessError) => {
        console.debug('===异常：' + error.message)
      })
  }

  saveAudioViewPicker() {
    this.audioPicker.save(this.audioSaveOptions)
      .then((result: Array<string>) => {
        this.saveUriList = result
      })
      .catch((error: BusinessError) => {
        console.debug('===异常：' + error.message)
      })
  }

  selectPhotoViewPicker() {
    this.photoViewPicker.select(this.photoSelectOptions)
      .then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
        this.uriMediaList = photoSelectResult.photoUris
        console.debug('===选择的图片uri：' + this.uriMediaList.toString())
      })
      .catch((error: BusinessError) => {
        console.debug('===异常：' + error.message)
      })
  }

  readFileContent(uri: string) {
    let file = fileIo.openSync(uri, fileIo.OpenMode.READ_ONLY)
    let arrayBuffer = new ArrayBuffer(4096)
    let readLen = fileIo.readSync(file.fd, arrayBuffer)
    let buf = buffer.from(arrayBuffer, 0, readLen)
    this.content = this.content + '\n' + buf.toString()
    fileIo.closeSync(file)
  }

  writeAndSaveFile(uri: string) {
    let file = fileIo.openSync(uri, fileIo.OpenMode.READ_WRITE);
    let writeLen: number = fileIO.writeSync(file.fd, '676171771717171');
    fileIo.closeSync(file)
  }

  async readMediaFile(uri: string) {
    let predicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
    predicates.equalTo(photoAccessHelper.PhotoKeys.URI, uri.toString());
    let fetchOptions: photoAccessHelper.FetchOptions = {
      fetchColumns: [photoAccessHelper.PhotoKeys.TITLE],
      predicates: predicates
    };

    try {
      let fetchResult: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset> =
        await this.phAccessHelper.getAssets(fetchOptions);
      let photoAsset: photoAccessHelper.PhotoAsset = await fetchResult.getFirstObject();
      console.info('getAssets photoAsset.uri : ' + photoAsset.uri);
      // 获取属性值，以标题为例；对于非默认查询的属性，get前需要在fetchColumns中添加对应列名
      console.info('title : ' + photoAsset.get(photoAccessHelper.PhotoKeys.TITLE));
      // 请求图片资源数据
      let requestOptions: photoAccessHelper.RequestOptions = {
        deliveryMode: photoAccessHelper.DeliveryMode.HIGH_QUALITY_MODE,
      }
      await photoAccessHelper.MediaAssetManager.requestImageData(this.context, photoAsset, requestOptions,
        new MediaDataHandler());
      console.info('requestImageData successfully');
      fetchResult.close();
    } catch (err) {
      console.error('getAssets failed with err: ' + err);
    }
  }

  persistPermission(uri:string) {
    // if (!canIUse('SystemCapability.FileManagement.File.Environment.FolderObtain')) {
    //   ToastUtils.show('this api is not supported on this device')
    //   return;
    // }
    // let policyInfo: fileShare.PolicyInfo = {
    //   uri: uri,
    //   operationMode: fileShare.OperationMode.READ_MODE,
    // };
    // let policies: Array<fileShare.PolicyInfo> = [policyInfo];
    // fileShare.persistPermission(policies).then(() => {
    //   console.info("persistPermission successfully");
    // }).catch((err: BusinessError<Array<fileShare.PolicyErrorResult>>) => {
    //   console.error("persistPermission failed with error message: " + err.message + ", error code: " + err.code);
    //   if (err.code == 13900001 && err.data) {
    //     for (let i = 0; i < err.data.length; i++) {
    //       console.error("error code : " + JSON.stringify(err.data[i].code));
    //       console.error("error uri : " + JSON.stringify(err.data[i].uri));
    //       console.error("error reason : " + JSON.stringify(err.data[i].message));
    //     }
    //   }
    // });
  }
}

class MediaDataHandler implements photoAccessHelper.MediaAssetDataHandler<ArrayBuffer> {
  onDataPrepared(data: ArrayBuffer) {
    if (data === undefined) {
      console.error('Error occurred when preparing data');
      return;
    }
    console.info('on image data prepared');
    // 应用自定义对资源数据的处理逻辑
    let s = buffer.from(data)
    console.debug('===最终结果：' + s)
  }
}