import { CommonButton } from '../component/MyComponent'
import { common, Permissions } from '@kit.AbilityKit'
import { PermissionUtils, ToastUtils } from '@ohos/common'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct CameraKitPage {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  private permissions: Array<Permissions> = [
    'ohos.permission.CAMERA',
    'ohos.permission.MICROPHONE',
    'ohos.permission.WRITE_MEDIA',
    'ohos.permission.READ_MEDIA',
    'ohos.permission.MEDIA_LOCATION'
  ]

  build() {
    Column() {
      CommonButton({ text: '打开相机' })
        .onClick(() => {
          this.checkPermissions()
        })
    }.width('100%')
  }

  checkPermissions() {
    PermissionUtils.getInstance()
      .checkPermissions(this.permissions, (isAllGrant: boolean, deniedPermissions: Array<Permissions>) => {
        if (isAllGrant) {
          this.openCameraPreview()
        } else {
          this.requestPermissions(deniedPermissions)
        }
      })
  }

  requestPermissions(permissions: Array<Permissions>) {
    PermissionUtils.getInstance()
      .reqPermissionsFromUser(this.context, permissions,
        (isAllGrant: boolean, deniedPermissions: Array<Permissions>) => {
          if (isAllGrant) {
            this.openCameraPreview()
          } else {
            ToastUtils.show('请自行打开权限设置')
            PermissionUtils.getInstance().openPermissionsInSystemSettings(this.context, 'com.example.myapplication')
          }
        })
  }

  openCameraPreview() {
    router.pushUrl({
      url: 'pages/camera/CameraPreviewPage'
    })
  }
}