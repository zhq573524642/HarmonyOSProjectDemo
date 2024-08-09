import { common } from '@kit.AbilityKit'
import { camera } from '@kit.CameraKit'
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils'
import { CommonButton } from '../component/MyComponent'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct CameraPreviewPage {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  private xComponentController: XComponentController = new XComponentController()

  build() {
    Column() {
      CommonButton({ text: '打开预览' })
        .onClick(() => {
          let cameraManager = this.getCameraManager(this.context)
          if (cameraManager) {
            let cameraDevice = this.getCameraDevices(cameraManager)
            if (cameraDevice != null && cameraDevice.length > 0) {
              this.getSupportedOutputCapability(cameraDevice[0], cameraManager, camera.SceneMode.NORMAL_PHOTO)
                .then((outputCapability: camera.CameraOutputCapability | undefined) => {
                  if (outputCapability) {
                    this.getPreviewOutput(cameraManager, outputCapability,
                      this.xComponentController.getXComponentSurfaceId())
                  }
                })
                .catch((error: BusinessError) => {
                  console.debug('===getSupportedOutputCapability失败:' + error.message)
                })
            }
          } else {
            ToastUtils.show('获取CameraManager失败，经检查是否被占用')
          }


        })
      XComponent({
        id: 'xCompoment1',
        type: XComponentType.SURFACE,
        controller: this.xComponentController
      })
        .onLoad(() => {
        })
        .onDestroy(() => {

        })
    }.width('100%')
  }

  //获取CameraManager对象
  getCameraManager(context: common.UIAbilityContext): camera.CameraManager {
    let cameraManager: camera.CameraManager = camera.getCameraManager(context)
    return cameraManager
  }

  //获取相机设备
  getCameraDevices(cameraManager: camera.CameraManager): Array<camera.CameraDevice> {
    let cameraDevices: Array<camera.CameraDevice> = cameraManager.getSupportedCameras()
    if (cameraDevices != undefined && cameraDevices.length > 0) {
      cameraDevices.forEach((value: camera.CameraDevice) => {
        console.debug('===设备：cameraId:' + value.cameraId + '\n'
          + 'cameraPosition:' + value.cameraPosition.toString() + '\n'
          + 'cameraType:' + value.cameraType.toString() + '\n'
          + 'connectionType:' + value.connectionType.toString() + '\n'
          + 'cameraOrientation:' + value.cameraOrientation)
      })
      return cameraDevices
    } else {
      return []
    }

  }

  //获取当前设备支持的所有输出流，如预览流、拍照流等
  async getSupportedOutputCapability(cameraDevice: camera.CameraDevice,
    cameraManager: camera.CameraManager,
    sceneMode: camera.SceneMode): Promise<camera.CameraOutputCapability | undefined> {
    //创建相机输入流
    let cameraInput: camera.CameraInput | undefined = undefined
    try {
      cameraInput = cameraManager.createCameraInput(cameraDevice)
    } catch (e) {
      let error = e as BusinessError
      console.error('===创建CameraInput失败：' + error.message)
    }

    if (cameraInput === undefined) {
      return undefined;
    }
    //打开相机
    await cameraInput.open();
    // 获取相机设备支持的输出流能力
    let cameraOutputCapability: camera.CameraOutputCapability =
      cameraManager.getSupportedOutputCapability(cameraDevice, sceneMode);
    if (!cameraOutputCapability) {
      console.error("===cameraManager.getSupportedOutputCapability error");
      return undefined;
    }
    console.info("===outputCapability: " + JSON.stringify(cameraOutputCapability));
    return cameraOutputCapability;
  }

  //创建会话
  getSession(cameraManager: camera.CameraManager): camera.Session | undefined {
    let session: camera.Session | undefined = undefined
    try {
      session = cameraManager.createSession(camera.SceneMode.NORMAL_PHOTO) as camera.PhotoSession
    } catch (e) {
      let error = e as BusinessError
      console.error('===CreateSession失败：' + error.message)
    }
    return session
  }

  getPreviewOutput(cameraManager: camera.CameraManager, cameraOutputCapability: camera.CameraOutputCapability,
    surfaceId: string): camera.PreviewOutput | undefined {
    let previewProfilesArray: Array<camera.Profile> = cameraOutputCapability.previewProfiles;
    let previewOutput: camera.PreviewOutput | undefined = undefined;
    try {
      previewOutput = cameraManager.createPreviewOutput(previewProfilesArray[0], surfaceId);
    } catch (error) {
      let err = error as BusinessError;
      console.error("Failed to create the PreviewOutput instance. error code: " + err.code);
    }
    return previewOutput;
  }

  async startPreviewOutput(cameraManager: camera.CameraManager, previewOutput: camera.PreviewOutput): Promise<void> {
    let cameraArray: Array<camera.CameraDevice> = [];
    cameraArray = cameraManager.getSupportedCameras();
    if (cameraArray.length == 0) {
      console.error('no camera.');
      return;
    }
    // 获取支持的模式类型
    let sceneModes: Array<camera.SceneMode> = cameraManager.getSupportedSceneModes(cameraArray[0]);
    let isSupportPhotoMode: boolean = sceneModes.indexOf(camera.SceneMode.NORMAL_PHOTO) >= 0;
    if (!isSupportPhotoMode) {
      console.error('photo mode not support');
      return;
    }
    let cameraInput: camera.CameraInput | undefined = undefined;
    cameraInput = cameraManager.createCameraInput(cameraArray[0]);
    if (cameraInput === undefined) {
      console.error('cameraInput is undefined');
      return;
    }
    // 打开相机
    await cameraInput.open();
    let session: camera.PhotoSession =
      cameraManager.createSession(camera.SceneMode.NORMAL_PHOTO) as camera.PhotoSession;
    session.beginConfig();
    session.addInput(cameraInput);
    session.addOutput(previewOutput);
    await session.commitConfig();
    await session.start();
  }
}
