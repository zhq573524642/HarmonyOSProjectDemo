import { customScan, scanBarcode, scanCore } from "@kit.ScanKit";
import { PermissionUtils, RouterUtil } from "../../../../Index";
import { common } from "@kit.AbilityKit";
import { display, promptAction, router } from "@kit.ArkUI";
import { BusinessError } from "@kit.BasicServicesKit";

@Entry({ routeName: 'CustomScanPage' })
@Component
export struct CustomScanPage {
  static startPageForResult(backPage: string) {
    RouterUtil.pushNamedRoute('CustomScanPage', {
      "backPage": backPage
    })
  }

  backPageName: string = ''
  @State scanTitle: string = '扫描二维码/条形码'
  @State scanSubTitle: string = '对准二维码/条形码，即可自动扫描'
  @State enableMultiMode: boolean = true //是否支持多码扫描
  @State enableAlbum: boolean = true //是否允许打开相册
  private context = getContext(this) as common.UIAbilityContext
  @State surfaceId: string = '' // xComponent组件生成id
  @State isShowBack: boolean = false // 是否已经返回扫码结果
  @State isFlashLightEnable: boolean = false // 是否需要闪光灯
  @State lightState: boolean = false //闪光灯状态
  @State isSensorLight: boolean = false // 记录当前环境亮暗状态
  @State cameraHeight: number = 640 // 设置预览流高度，默认单位：vp
  @State cameraWidth: number = 360 // 设置预览流宽度，默认单位：vp
  @State offsetX: number = 0 // 设置预览流x轴方向偏移量，默认单位：vp
  @State offsetY: number = 0 // 设置预览流y轴方向偏移量，默认单位：vp
  @State zoomValue: number = 1 // 预览流缩放比例
  @State setZoomValue: number = 1 // 已设置的预览流缩放比例
  @State scaleValue: number = 1 // 屏幕缩放比
  @State pinchValue: number = 1 // 双指缩放比例
  @State displayHeight: number = 0 // 屏幕高度，单位vp
  @State displayWidth: number = 0 // 屏幕宽度，单位vp
  @State scanResult: Array<scanBarcode.ScanResult> = [] // 扫码结果
  private mXComponentController: XComponentController = new XComponentController()

  onScanResultCallback(result: scanBarcode.ScanResult) {
    this.getUIContext().getRouter().back({
      url: this.backPageName,
      params: {
        "ScanResult": result
      }
    })
  }

  aboutToAppear(): void {
    const params = router.getParams() as Record<string, Object>
    if (params) {
      this.backPageName = params.backPage as string
    }
  }

  onPageShow(): void {
    let options: scanBarcode.ScanOptions = {
      scanTypes: [scanCore.ScanType.ALL],
      enableMultiMode: this.enableMultiMode,
      enableAlbum: this.enableAlbum
    }
    // 自定义启动第二步：设置预览流布局尺寸
    this.setDisplay();
    try {
      customScan.init(options)
    } catch (e) {
    }
  }

  async onPageHide() {
    // 页面消失或隐藏时，停止并释放相机流
    this.isFlashLightEnable = false;
    this.isSensorLight = false;
    try {
      customScan.off('lightingFlash');
    } catch (error) {
    }
    this.customScanStop();
    try {
      // 自定义相机流释放接口
      customScan.release().then(() => {
      }).catch((error: BusinessError) => {

      })
    } catch (error) {
    }
  }

  // 竖屏时获取屏幕尺寸，设置预览流全屏示例
  setDisplay() {
    try {
      // 默认竖屏
      let displayClass = display.getDefaultDisplaySync();
      this.displayHeight = px2vp(displayClass.height);
      this.displayWidth = px2vp(displayClass.width);
      let maxLen: number = Math.max(this.displayWidth, this.displayHeight);
      let minLen: number = Math.min(this.displayWidth, this.displayHeight);
      const RATIO: number = 16 / 9;
      this.cameraHeight = maxLen;
      this.cameraWidth = maxLen / RATIO;
      this.offsetX = (minLen - this.cameraWidth) / 2;
    } catch (error) {
    }
  }

  initCamera() {
    this.isShowBack = false;
    this.scanResult = [];
    let viewControl: customScan.ViewControl = {
      width: this.cameraWidth,
      height: this.cameraHeight,
      surfaceId: this.surfaceId
    };
    try {
      // 自定义启动第四步，请求扫码接口，通过Promise方式回调
      customScan.start(viewControl)
        .then(async (result: Array<scanBarcode.ScanResult>) => {

          if (result.length) {
            // 解析码值结果跳转应用服务页
            if (result.length > 1) {
              console.debug(`===扫描结果-显示箭头：result: ${JSON.stringify(result)}`)
              this.scanResult = result;
            } else {
              console.debug(`===扫描结果-直接返回：result: ${JSON.stringify(result)}`)
              this.onScanResultCallback(result[0])
            }

            this.isShowBack = true;
            // 获取到扫描结果后暂停相机流
            this.customScanStop();
          }
        });
    } catch (error) {
    }
  }

  customScanStop() {
    try {
      customScan.stop();
    } catch (error) {
    }
  }

  // 自定义扫码界面的顶部返回按钮和扫码提示
  @Builder
  TopTool() {
    Column() {
      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Image($r('app.media.ic_scan_close')).width(35).height(35)
          .objectFit(ImageFit.Fill)
          .onClick(async () => {
            this.getUIContext().getRouter().back({
              url: this.backPageName
            })
          })
      }.padding({ left: 24, right: 24, top: 40 })

      Column({ space: 10 }) {
        Text(this.scanTitle)
          .fontColor(Color.White).fontSize(18)
        Text(this.scanSubTitle)
          .fontColor(Color.White).fontSize(18)
      }.margin({ left: 24, right: 24, top: 24 })
    }
    .height(146)
    .width('100%')
  }

  public customGetZoom(): number {
    let zoom = 1;
    try {
      zoom = customScan.getZoom();
    } catch (error) {
    }
    return zoom;
  }

  public customSetZoom(pinchValue: number): void {
    try {
      customScan.setZoom(pinchValue);
    } catch (error) {
    }
  }

  build() {
    Stack() {
      Column() {
        XComponent({
          id: 'componentId',
          type: XComponentType.SURFACE,
          controller: this.mXComponentController
        })
          .onLoad(async () => {
            // 获取XComponent组件的surfaceId
            this.surfaceId = this.mXComponentController.getXComponentSurfaceId();
            this.initCamera();
            // 闪光灯监听接口
            customScan.on('lightingFlash', (error, isLightingFlash) => {
              if (error) {
                return;
              }
              if (isLightingFlash) {
                this.isFlashLightEnable = true;
              } else {
                try {
                  let lightStatus = customScan.getFlashLightStatus()
                  this.lightState = lightStatus
                  if (!lightStatus) {
                    this.isFlashLightEnable = false;
                  }
                } catch (error) {

                }
              }
              this.isSensorLight = isLightingFlash;
            });
          })
          .width(this.cameraWidth)
          .height(this.cameraHeight)
          .position({ x: this.offsetX, y: this.offsetY })
      }
      .height('100%')
      .width('100%')

      Column() {
        this.TopTool()
        Column() {
        }
        .layoutWeight(1)
        .width('100%')

        Column() {
          Row() {
            // 闪光灯按钮，启动相机流后才能使用
            Image(this.lightState ? $r('app.media.ic_light_on') : $r('app.media.ic_light_off'))
              .width(30)
              .height(30)
              .onClick(() => {
                let lightStatus: boolean = false;
                try {
                  lightStatus = customScan.getFlashLightStatus();
                } catch (error) {

                }

                // 根据当前闪光灯状态，选择打开或关闭闪关灯
                if (lightStatus) {
                  try {
                    customScan.closeFlashLight();
                    this.lightState = false
                    setTimeout(() => {
                      this.isFlashLightEnable = this.isSensorLight;
                    }, 200);
                  } catch (error) {

                  }
                } else {
                  try {
                    customScan.openFlashLight();
                    this.lightState = true
                  } catch (error) {

                  }
                }
              })
              .visibility(this.isFlashLightEnable ? Visibility.Visible : Visibility.None)


            // 扫码成功后，点击按钮后重新扫码
            Text('重新扫码').fontColor(Color.White).fontSize(16)
              .onClick(() => {
                // 点击按钮重启相机流，重新扫码
                this.initCamera();
              })
              .visibility(this.isShowBack ? Visibility.Visible : Visibility.None)

          }

          // Row() {
          //   // 预览流设置缩放比例
          //   Button('缩放比例,当前比例:' + this.setZoomValue)
          //     .onClick(() => {
          //       // 设置相机缩放比例
          //       if (!this.isShowBack) {
          //         if (!this.zoomValue || this.zoomValue === this.setZoomValue) {
          //           this.setZoomValue = this.customGetZoom();
          //         } else {
          //           this.zoomValue = this.zoomValue;
          //           this.customSetZoom(this.zoomValue);
          //           setTimeout(() => {
          //             if (!this.isShowBack) {
          //               this.setZoomValue = this.customGetZoom();
          //             }
          //           }, 1000);
          //         }
          //       }
          //     })
          // }
          // .margin({ top: 10, bottom: 10 })

          // Row() {
          //   // 输入要设置的预览流缩放比例
          //   TextInput({ placeholder: '输入缩放倍数' })
          //     .type(InputType.Number)
          //     .borderWidth(1)
          //     .backgroundColor(Color.White)
          //     .onChange(value => {
          //       this.zoomValue = Number(value);
          //     })
          // }
        }
        .width('50%')
        .height(180)
      }

      // 单码、多码扫描后，显示码图蓝点位置。点击toast码图信息
      ForEach(this.scanResult, (item: scanBarcode.ScanResult, index: number) => {
        if (item.scanCodeRect) {
          Image($rawfile('scan_selected2.svg'))
            .width(40)
            .height(40)
            .markAnchor({ x: 20, y: 20 })
            .position({
              x: (item.scanCodeRect.left + item?.scanCodeRect?.right) / 2 + this.offsetX,
              y: (item.scanCodeRect.top + item?.scanCodeRect?.bottom) / 2 + this.offsetY
            })
            .onClick(() => {
              this.showScanResult(item);
            })
        }
      })

    }
    // 建议相机流设置为全屏
    .width('100%')
    .height('100%')
    .onClick((event: ClickEvent) => {
      // 是否已扫描到结果
      if (this.isShowBack) {
        return;
      }
      // 点击屏幕位置，获取点击位置(x,y)，设置相机焦点
      let x1 = vp2px(event.displayY) / (this.displayHeight + 0.0);
      let y1 = 1.0 - (vp2px(event.displayX) / (this.displayWidth + 0.0));
      try {
        customScan.setFocusPoint({ x: x1, y: y1 });

      } catch (error) {

      }
      // 设置连续自动对焦模式
      setTimeout(() => {
        try {
          customScan.resetFocus();
        } catch (error) {
        }
      }, 200);
    }).gesture(PinchGesture({ fingers: 2 })
      .onActionStart((event: GestureEvent) => {
      })
      .onActionUpdate((event: GestureEvent) => {
        if (event) {
          this.scaleValue = event.scale;
        }
      })
      .onActionEnd((event: GestureEvent) => {
        // 是否已扫描到结果
        if (this.isShowBack) {
          return;
        }
        // 获取双指缩放比例，设置变焦比
        try {
          let zoom = this.customGetZoom();
          this.pinchValue = this.scaleValue * zoom;
          this.customSetZoom(this.pinchValue);
        } catch (error) {
        }
      }))
  }

  // toast显示扫码结果
  async showScanResult(result: scanBarcode.ScanResult) {
    // 使用toast显示出扫码结果
    this.onScanResultCallback(result)
  }
}