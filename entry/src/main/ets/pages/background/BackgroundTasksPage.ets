import { CommonButton, CommonTitle } from "../component/MyComponent"
import backgroundTaskManager from "@ohos.resourceschedule.backgroundTaskManager"
import { BusinessError } from "@kit.BasicServicesKit"
import { RouterUtil, ToastUtils } from "@ohos/common"
import Router from "@system.router"

@Entry({ routeName: 'BackgroundTasksPage' })
@ComponentV2
export struct BackgroundTasksPage {
  static startPage() {
    RouterUtil.pushNamedRoute('BackgroundTasksPage')
  }

  build() {
    Column() {
      CommonTitle({ title: '短时任务' })
      CommonButton({ text: '申请短时任务' })
        .onClick(() => {
          if (this.shortTaskRequestId === 0) {
            this.requestSuspendDelayTask()
          } else {
            ToastUtils.show('已经申请短时任务')
          }
        })
      CommonButton({ text: '获取短时任务剩余时间' })
        .onClick(() => {
          if (this.shortTaskRequestId !== 0) {
            this.getShortTaskRemainingDelayTime()
          } else {
            ToastUtils.show('请先申请短时任务')
          }
        })
      CommonButton({ text: '取消短时任务' })
        .onClick(() => {
          if (this.shortTaskRequestId !== 0) {
            this.cancelShortDelayTask()
          } else {
            ToastUtils.show('请先申请短时任务')
          }
        })

      CommonTitle({ title: '长时任务' })
      CommonButton({ text: '申请长时任务' })
        .onClick(() => {
          //1.配置权限 ohos.permission.KEEP_BACKGROUND_RUNNING
          //2.在module.json5文件中为需要使用长时任务的UIAbility声明相应的长时任务类型
          // "module": {
          //      "abilities": [
          //          {
          //              "backgroundModes": [
          //               // 长时任务类型的配置项
          //              "audioRecording"
          //              ]
          //          }
          //      ],
          //      // ...
          //  }

        })
    }.width('100%')
    .height('100%')
  }

  //短时任务
  //申请短时任务
  shortTaskRequestId: number = 0
  actualDelayTime: number = 0

  requestSuspendDelayTask() {
    let reason: string = 'Test 申请短时任务'
    let shortDelayTaskInfo = backgroundTaskManager.requestSuspendDelay(reason, () => {
      // 回调函数。应用申请的短时任务即将超时，通过此函数回调应用，执行一些清理和标注工作，并取消短时任务
      console.debug('===短时任务即将超时：' + this.shortTaskRequestId)
      // 取消短时任务
      this.cancelShortDelayTask()
    })
    //获取短时任务申请Id
    this.shortTaskRequestId = shortDelayTaskInfo.requestId
    //本次短时任务剩余时间
    this.actualDelayTime = shortDelayTaskInfo.actualDelayTime
    //执行短时任务
    setTimeout(() => {
      console.debug('===执行任务了')
      ToastUtils.show('执行任务了')
      this.cancelShortDelayTask()
    }, 5000)
  }

  async getShortTaskRemainingDelayTime() {
    backgroundTaskManager.getRemainingDelayTime(this.shortTaskRequestId)
      .then((time: number) => {
        console.debug('===获取短时任务剩余时间成功：' + time)
      }).catch((error: BusinessError) => {
      console.debug('===获取短时任务剩余时间失败：' + error.code + '--' + error.message)
    })
  }

  cancelShortDelayTask() {
    backgroundTaskManager.cancelSuspendDelay(this.shortTaskRequestId)
    this.shortTaskRequestId = 0
  }
}

