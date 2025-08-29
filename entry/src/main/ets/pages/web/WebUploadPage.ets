import { PageRouter } from "../../router/PageRouter";
import { router } from "@kit.ArkUI";
import { webview } from "@kit.ArkWeb";
import { picker } from "@kit.CoreFileKit";
import { ToastUtils } from "@ohos/common";
import { BusinessError } from "@kit.BasicServicesKit";
import { RadioList } from "../component/MyComponent";
import photoAccessHelper from "@ohos.file.photoAccessHelper";
import { common } from "@kit.AbilityKit";
import { camera, cameraPicker } from "@kit.CameraKit";

@Entry({ routeName: PageRouter.PAGE_WEB_UPLOAD })
@Component
export struct WebUploadPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_WEB_UPLOAD
    }, router.RouterMode.Single)
  }

  webController: webview.WebviewController = new webview.WebviewController()
  @State selectType: number = 1

  build() {
    Column() {
      Row() {
        RadioList({
          title: '选择类型',
          data: ['选择文件', '选择图片', '打开相机','根据accept默认'],
          onCheckChange: (position: number, isChange: boolean) => {
            if (isChange) {
              this.selectType = position + 1
            }
          }
        })
      }.width('100%')
      .alignItems(VerticalAlign.Center)


      Web({ src: $rawfile('localh5.html'), controller: this.webController })
        .onShowFileSelector((event) => {
          console.debug('===Event-Title:' + event.fileSelector.getTitle())
          console.debug('===Event-Mode:' + event.fileSelector.getMode().toString())
          console.debug('===Event-AcceptType:' + event.fileSelector.getAcceptType().toString())
          if (this.selectType===4){
            //AcceptType
            //图片：image/*
            //视频：video/*
            //图片：tif, xbm, tiff, pjp, jfif, bmp, avif, apng, ico, webp, svg, gif, svgz, jpg, jpeg, png, pjpeg
            //视频：mp4, mpg, mpeg, m4v, ogm, ogv, webm
            //ArkWeb默认仅拉起相机后置摄像头，值 'user'不会被处理成拉起前置摄像头。
            //如有需要，请在应用侧通过onShowFileSelector()接口另行处理
            return false
          }
          if (this.selectType === 1) {
            this.selectFile(event)
          } else if (this.selectType === 2) {
            this.selectPicture(event)
          } else if (this.selectType===3){
            openCamera((result) => {
              if (event) {
                event.result.handleFileList([result])
              }
            }, this.getUIContext())
          }
          return true
        })
        .width('100%')
        .layoutWeight(1)
    }.height('100%')
    .width('100%')
  }

  selectFile(event: OnShowFileSelectorEvent) {
    //1.创建文件选择picker的参数
    const documentSelectOptions = new picker.DocumentSelectOptions()
    let uri: string | null = null
    const documentViewPicker = new picker.DocumentViewPicker()
    documentViewPicker.select(documentSelectOptions)
      .then((documentSelectResult) => {
        if (documentSelectResult.length > 0) {
          uri = documentSelectResult[0]
        } else {
          ToastUtils.show('未选择任何文件')
        }
        if (event) {
          if (uri) {
            event.result.handleFileList([uri])
          } else {
            event.result.handleFileList([])
          }
        }

      })
      .catch((error: BusinessError) => {
        console.debug('===选择文件失败：' + error.code + '--' + error.message)
      })
  }

  async selectPicture(event: OnShowFileSelectorEvent): Promise<void> {
    if (event) {
      let photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      let photoPicker = new photoAccessHelper.PhotoViewPicker();
      // 过滤选择媒体文件类型为IMAGE
      photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
      // 设置最大选择数量
      photoSelectOptions.maxSelectNumber = 5;
      let chooseFile: picker.PhotoSelectResult = await photoPicker.select(photoSelectOptions);
      // 获取选择的文件列表
      event.result.handleFileList(chooseFile.photoUris);
    }

  }
}

async function openCamera(callback: Callback<string>, uiContext: UIContext) {
  let mContext = uiContext.getHostContext() as common.Context;
  try {
    let pickerProfile: cameraPicker.PickerProfile = {
      cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
    };
    let pickerResult: cameraPicker.PickerResult = await cameraPicker.pick(mContext,
      [cameraPicker.PickerMediaType.PHOTO, cameraPicker.PickerMediaType.VIDEO], pickerProfile);
    callback(pickerResult.resultUri);
  } catch (error) {
    let err = error as BusinessError;
    console.error(`the pick call failed. error code: ${err.code}`);
  }
}