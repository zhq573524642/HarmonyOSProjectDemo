import { CommonButton } from '../component/MyComponent';
import picker from '@ohos.file.picker';
import { camera, cameraPicker } from '@kit.CameraKit';
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils';
import { common, Permissions } from '@kit.AbilityKit';
import { PermissionUtils } from '@ohos/common';

@Entry
@Component
struct CameraPickerPage {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  private permissions: Array<Permissions> = [
    'ohos.permission.CAMERA',
    'ohos.permission.MICROPHONE',
    'ohos.permission.WRITE_MEDIA',
    'ohos.permission.READ_MEDIA',
    'ohos.permission.MEDIA_LOCATION'
  ]
  @State imageUri: string = ''
  @State videoUri: string = ''
  pickerProfile: cameraPicker.PickerProfile = {
    cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK, //后置相机
    saveUri: '',
    videoDuration: 60000
  }

  build() {
    Column({space:10}) {
      CommonButton({ text: 'cameraPicker.pick：拍照' })
        .onClick(() => {
          this.checkPermissions(true)
        })

      CommonButton({ text: 'cameraPicker.pick：录制' })
        .onClick(() => {
          this.checkPermissions(false)
        })
      Image(this.imageUri).width(150).height(150)
      Video({src:this.videoUri})
        .autoPlay(true)
        .loop(true)
        .controls(true)
        .width('80%')
        .height(300)
    }.width('100%')
    .height('100%')
  }

  checkPermissions(isPhoto: boolean = true) {
    PermissionUtils.getInstance()
      .checkPermissions(this.permissions, (isAllGrant: boolean, deniedPermissions: Array<Permissions>) => {
        if (isAllGrant) {
          if (isPhoto) {
            this.takePhoto()
          } else {
            this.takeVideo()
          }
        } else {
          this.requestPermissions(deniedPermissions, isPhoto)
        }
      })
  }

  requestPermissions(permissions: Array<Permissions>, isPhoto: boolean = true) {
    PermissionUtils.getInstance()
      .reqPermissionsFromUser(this.context, permissions,
        (isAllGrant: boolean, deniedPermissions: Array<Permissions>) => {
          if (isAllGrant) {
            if (isPhoto) {
              this.takePhoto()
            } else {
              this.takeVideo()
            }
          } else {
            ToastUtils.show('请自行打开权限设置')
            PermissionUtils.getInstance().openPermissionsInSystemSettings()
          }
        })
  }

  takePhoto() {
    cameraPicker.pick(getContext(this), [cameraPicker.PickerMediaType.PHOTO],
      this.pickerProfile)
      .then((result: cameraPicker.PickerResult) => {
        if (result) {
          if (result.resultCode == 0) {
            //成功
            this.imageUri = result.resultUri
          } else {
            //失败
            ToastUtils.show('拍照失败')
          }
        }
      })
  }

  takeVideo() {
    cameraPicker.pick(getContext(this), [cameraPicker.PickerMediaType.VIDEO],
      this.pickerProfile)
      .then((result: cameraPicker.PickerResult) => {
        if (result) {
          if (result.resultCode == 0) {
            //成功
            this.videoUri = result.resultUri
          } else {
            //失败
            ToastUtils.show('录制失败')
          }
        }
      })
  }
}