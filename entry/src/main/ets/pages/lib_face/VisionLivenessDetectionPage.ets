/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { common, abilityAccessCtrl, Permissions } from '@kit.AbilityKit';
import { interactiveLiveness } from '@kit.VisionKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct VisionLivenessDetectionPage {
  private context = this.getUIContext()?.getHostContext() as common.UIAbilityContext;
  private array: Array<Permissions> = ["ohos.permission.CAMERA"];
  @State actionsNum: number = 0;
  @State isSilentMode: string = 'INTERACTIVE_MODE';
  @State routeMode: string = 'replace';
  @State resultInfo: interactiveLiveness.InteractiveLivenessResult = {
    livenessType: 0
  };
  @State failResult: Record<string, number | string> = {
    'code': 1008302000,
    'message': ''
  };

  build() {
    Stack({
      alignContent: Alignment.Top
    }) {
      Column() {
        Text('Redirection mode after detection:')
          .fontSize(18)
          .width('100%')
        Row() {
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
              Row() {
                Radio({ value: 'replace', group: 'routeMode' }).checked(true)
                  .height(24)
                  .width(24)
                  .onChange((isChecked: boolean) => {
                    this.routeMode = 'replace'
                  })
                Text('Replace')
                  .fontSize(16)
              }
              .margin({ right: 15 })

              Row() {
                Radio({ value: 'back', group: 'routeMode' }).checked(false)
                  .height(24)
                  .width(24)
                  .onChange((isChecked: boolean) => {
                    this.routeMode = 'back';
                  })
                Text('Back')
                  .fontSize(16)
              }
              .margin({ left: 100 })
            }
            .width('75%')
          }
        }
        .margin({ bottom: 30 })

        Row() {
          Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Text('Actions:')
              .fontSize(18)
              .width('25%')
            TextInput({
              placeholder: this.actionsNum != 0 ? this.actionsNum.toString() : "Enter 3 or 4."
            })
              .type(InputType.Number)
              .placeholderFont({
                size: 18,
                weight: FontWeight.Normal,
                family: "HarmonyHeiTi",
                style: FontStyle.Normal
              })
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontFamily("HarmonyHeiTi")
              .fontStyle(FontStyle.Normal)
              .width('65%')
              .onChange((value: string) => {
                this.actionsNum = Number(value) as interactiveLiveness.ActionsNumber;
              })
          }
        }
      }
      .margin({ left: 24, top: 50 })
      .zIndex(1)

      Stack({
        alignContent: Alignment.Bottom
      }) {
        if (this.resultInfo?.mPixelMap) {
          Image(this.resultInfo?.mPixelMap)
            .width(260)
            .height(260)
            .align(Alignment.Center)
            .margin({ bottom: 260 })
          Circle()
            .width(300)
            .height(300)
            .fillOpacity(0)
            .strokeWidth(60)
            .stroke(Color.White)
            .margin({ bottom: 250, left: 0 })
        }

        Text(this.resultInfo.mPixelMap ?
          'Detection succeeded' :
          this.failResult.code != 1008302000 ?
            'Detection failed' :
            '')
          .width('100%')
          .height(26)
          .fontSize(20)
          .fontColor($r('sys.color.black'))
          .fontFamily('HarmonyHeiTi')
          .margin({ top: 50 })
          .textAlign(TextAlign.Center)
          .fontWeight('Medium')
          .margin({ bottom: 240 })

        if (this.failResult.code != 1008302000) {
          Text(this.failResult.message as string)
            .width('100%')
            .height(26)
            .fontSize(16)
            .fontColor(Color.Gray)
            .textAlign(TextAlign.Center)
            .fontFamily('HarmonyHeiTi')
            .fontWeight('Medium')
            .margin({ bottom: 200 })
        }

        Button("Start detection", { type: ButtonType.Normal, stateEffect: true })
          .width(192)
          .height(40)
          .fontSize(16)
          .backgroundColor(0x317aff)
          .borderRadius(20)
          .margin({
            bottom: 56
          })
          .onClick(() => {
            this.privateStartDetection();
          })
      }
      .height('100%')
    }
  }

  onPageShow() {
    this.resultRelease();
    this.getDetectionResultInfo();
  }

  // Route to the face liveness detection control.
  private privateRouterLibrary() {
    let routerOptions: interactiveLiveness.InteractiveLivenessConfig = {
      isSilentMode: this.isSilentMode as interactiveLiveness.DetectionMode,
      routeMode: this.routeMode as interactiveLiveness.RouteRedirectionMode,
      actionsNum: this.actionsNum,
    }

    if (canIUse("SystemCapability.AI.Component.LivenessDetect")) {
      interactiveLiveness.startLivenessDetection(routerOptions).then((DetectState: boolean) => {
        hilog.info(0x0001, "LivenessCollectionIndex", `Succeeded in jumping.`);
      }).catch((err: BusinessError) => {
        hilog.error(0x0001, "LivenessCollectionIndex", `Failed to jump. Code：${err.code}，message：${err.message}`);
      })
    } else {
      hilog.error(0x0001, "LivenessCollectionIndex", 'this api is not supported on this device');
    }
  }

  // Verify the camera permission.
  private privateStartDetection() {
    abilityAccessCtrl.createAtManager().requestPermissionsFromUser(this.context, this.array).then((res) => {
      for (let i = 0; i < res.permissions.length; i++) {
        if (res.permissions[i] === "ohos.permission.CAMERA" && res.authResults[i] === 0) {
          this.privateRouterLibrary();
        }
      }
    }).catch((err: BusinessError) => {
      hilog.error(0x0001, "LivenessCollectionIndex",
        `Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })
  }

  // Obtain the detection result.
  private getDetectionResultInfo() {
    // Resources are released after the getInteractiveLivenessResult API calling is complete.
    if (canIUse("SystemCapability.AI.Component.LivenessDetect")) {
      let resultInfo = interactiveLiveness.getInteractiveLivenessResult();
      resultInfo.then(data => {
        this.resultInfo = data;
      }).catch((err: BusinessError) => {
        this.failResult = {
          'code': err.code,
          'message': err.message
        }
      })
    } else {
      hilog.error(0x0001, "LivenessCollectionIndex", 'this api is not supported on this device');
    }
  }

  // Result release.
  private resultRelease() {
    this.resultInfo = {
      livenessType: 0
    }
    this.failResult = {
      'code': 1008302000,
      'message': ''
    }
  }
}