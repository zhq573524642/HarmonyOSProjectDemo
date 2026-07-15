import { common } from '@kit.AbilityKit'
import { camera } from '@kit.CameraKit'
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils'
import { CommonButton } from '../component/MyComponent'
import { BusinessError } from '@kit.BasicServicesKit'
import { display } from '@kit.ArkUI'

@Entry
@Component
struct CameraPreviewPage {
  private uiContext: UIContext = this.getUIContext();
  private context: Context | undefined = this.uiContext.getHostContext();
  private xComponentController: XComponentController = new XComponentController()
  @State imageWidth: number = 1080;
  @State imageHeight: number = 1920;
  private xComponentSurfaceId: string = ''
  private cameraManager: camera.CameraManager | undefined = undefined;
  private cameras: Array<camera.CameraDevice> | undefined = [];
  private cameraInput: camera.CameraInput | undefined = undefined;
  private previewOutput: camera.PreviewOutput | undefined = undefined;
  private session: camera.VideoSession | undefined = undefined;

  onPageShow(): void {
    console.info('onPageShow');
    if (this.xComponentSurfaceId !== '') {
      this.initCamera();
    }
  }

  onPageHide(): void {
    console.info('onPageHide');
    this.releaseCamera();
  }

  build() {
    Column() {
      XComponent({
        id: 'xCompoment1',
        type: XComponentType.SURFACE,
        controller: this.xComponentController
      })
        .width(this.uiContext.px2vp(this.imageWidth))
        .height(this.uiContext.px2vp(this.imageHeight))
        .onLoad(() => {
          //获取组件的surfaceId
          this.xComponentSurfaceId = this.xComponentController.getXComponentSurfaceId()
          const width = display.getDefaultDisplaySync().width
          const height = display.getDefaultDisplaySync().height
          this.imageWidth = width
          this.imageHeight = height
          let surfaceRect: SurfaceRect = {
            surfaceWidth: width,
            surfaceHeight: height, // / (1125 / 1500),
          }
          this.xComponentController.setXComponentSurfaceRect(surfaceRect)
          this.initCamera()
        })
        .onDestroy(() => {

        })
    }.width('100%')
  }

  // 初始化相机。
  async initCamera(): Promise<void> {
    console.info(`====initCamera previewOutput xComponentSurfaceId:${this.xComponentSurfaceId}`);
    try {
      // 获取相机管理器实例。
      this.cameraManager = camera.getCameraManager(this.context);
      if (!this.cameraManager) {
        console.error('===initCamera getCameraManager');
        return;
      }
      // 获取当前设备支持的相机device列表。
      this.cameras = this.cameraManager.getSupportedCameras();
      if (!this.cameras) {
        console.error('===initCamera getSupportedCameras');
      }
      // 选择一个相机device，创建cameraInput输出对象。
      this.cameraInput = this.cameraManager.createCameraInput(this.cameras[0]);
      if (!this.cameraInput) {
        console.error('===initCamera createCameraInput');
        return;
      }
      // 打开相机。
      await this.cameraInput.open();
      // 获取相机device支持的profile。
      let capability: camera.CameraOutputCapability =
        this.cameraManager.getSupportedOutputCapability(this.cameras[0], camera.SceneMode.NORMAL_VIDEO);
      if (!capability || capability.previewProfiles.length === 0) {
        console.error('===capability is null || []');
        this.releaseCamera();
        return;
      }
      let minRatioDiff: number = 0.1;
      let surfaceRatio: number = this.imageWidth / this.imageHeight; // 最接近16:9宽高比。
      let previewProfile: camera.Profile = capability.previewProfiles[0];
      // 应用开发者根据实际业务需求选择一个支持的预览流previewProfile。
      // 此处以选择CAMERA_FORMAT_YUV_420_SP（NV21）格式、满足限定条件分辨率的预览流previewProfile为例。
      for (let index = 0; index < capability.previewProfiles.length; index++) {
        const tempProfile = capability.previewProfiles[index];
        let tempRatio = tempProfile.size.width >= tempProfile.size.height ?
          tempProfile.size.width / tempProfile.size.height : tempProfile.size.height / tempProfile.size.width;
        let currentRatio = Math.abs(tempRatio - surfaceRatio);
        if (currentRatio <= minRatioDiff && tempProfile.format == camera.CameraFormat.CAMERA_FORMAT_YUV_420_SP) {
          previewProfile = tempProfile;
          break;
        }
      }
      this.imageWidth = previewProfile.size.width; // 更新xComponent组件的宽。
      this.imageHeight = previewProfile.size.height; // 更新xComponent组件的高。
      console.info(`===initCamera imageWidth:${this.imageWidth} imageHeight:${this.imageHeight}`);

      // 使用xComponentSurfaceId创建预览。
      this.previewOutput = this.cameraManager.createPreviewOutput(previewProfile, this.xComponentSurfaceId);
      if (!this.previewOutput) {
        console.error('===initCamera createPreviewOutput');
        this.releaseCamera();
        return;
      }
      // 创建录像模式相机会话。
      let session = this.cameraManager.createSession(camera.SceneMode.NORMAL_VIDEO);
      if (!session) {
        console.error('===session is null');
        this.releaseCamera();
        return;
      }
      this.session = session as camera.VideoSession;
      // 开始配置会话。
      this.session.beginConfig();
      // 添加相机设备输入。
      this.session.addInput(this.cameraInput);
      // 添加预览流输出。
      this.session.addOutput(this.previewOutput);
      // 提交会话配置。
      await this.session.commitConfig();
      // 开始启动已配置的输入输出流。
      await this.session.start();
    } catch (error) {
      console.error(`===initCamera fail: ${JSON.stringify(error)}`);
      this.releaseCamera();
    }
  }

  // 释放相机。
  async releaseCamera(): Promise<void> {
    console.info('===releaseCamera');
    // 停止当前会话。
    await this.session?.stop().catch((e: BusinessError) => {
      console.error('===Failed to stop session: ', e)
    });
    // 释放相机输入流。
    await this.cameraInput?.close().catch((e: BusinessError) => {
      console.error('===Failed to close the camera: ', e)
    });
    // 释放预览输出流。
    await this.previewOutput?.release().catch((e: BusinessError) => {
      console.error('===Failed to stop the preview stream: ', e)
    });
    // 释放会话。
    await this.session?.release().catch((e: BusinessError) => {
      console.error('===Failed to release session: ', e)
    });
  }
}
