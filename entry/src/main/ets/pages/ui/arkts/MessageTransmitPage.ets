import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { promptAction, router } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'
import { BusinessError, commonEventManager, emitter } from '@kit.BasicServicesKit'
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils'

const FLAG_EMITTER_MSG: number = 1001
const FLAG_EVENT_HUB_MSG: string = 'event_1'
const FLAG_COMMON_EVENT_NAME: string = 'common_event_1'

@Entry
@Component
struct MessageTransmitPage {
  scroller: Scroller = new Scroller()
  @State showBackParam: string = '页面返回参数在这里显示'
  //获取上下文
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext

  aboutToAppear(): void {
    this.registerEmitter()
    this.registerEventHub()
  }

  aboutToDisappear(): void {
    this.unregisterEmitter()
    this.unregisterEventHub()
  }

  eventHubFunc(arg1: Context, arg2: Context) {
    promptAction.showToast({ message: `收到消息：数据1：${arg1}，数据2：${arg2}` })
    console.debug('===收到EventHub消息2：' + arg1 + '--' + arg2)
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: 'router页面间数据传递' })
        Text(`页面跳转回传参数：${this.showBackParam}`)
          .margin(8)
          .fontSize(15)
        CommonButton({ text: 'router页面跳转并传递参数' })
          .onClick(() => {
            jumpPageWithParams()
          })
        CommonButton({ text: 'Navigation页面跳转并传递参数' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/navigation/NavigationTestPage' })
          })
        CommonTitle({ title: 'EventHub：UIAbility与UI的数据同步' })
        CommonButton({ text: '发送EventHub事件' })
          .onClick(() => {
            // this.context.eventHub.emit('event_1')
            // this.context.eventHub.emit('event_1', '哈哈哈')
            this.context.eventHub.emit('event_1', '啦啦啦', 18)
          })
        CommonButton({ text: 'Emitter线程间通信' })
          .onClick(() => {
            // 定义一个eventId为1的事件，事件优先级为Low
            let event: emitter.InnerEvent = {
              eventId: FLAG_EMITTER_MSG,
              priority: emitter.EventPriority.IMMEDIATE
            };

            let eventData: emitter.EventData = {
              data: {
                isUpdate: true
              }
            };
            // 发送eventId为1的事件，事件内容为eventData
            emitter.emit(event, eventData);
          })
        CommonTitle({ title: '进程间通信' })
        CommonTitle({ title: '自定义/系统公共事件' })
        Row() {
          Button('1.create')
            .onClick(() => {
              this.createSubscribeCommonEvent()
            })
          Button('2.subscribe')
            .onClick(() => {
              this.subscribeCommonEvent()
            })


        }.width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Row() {
          Button('3.publish')
            .onClick(() => {
              this.publishCommonEvent(false)
            })
          Button('3.publish_data')
            .onClick(() => {
              this.publishCommonEvent(true)
            })
          Button('4.unsubscribe')
            .onClick(() => {
              this.unsubscribeCommonEvent()
            })
        }.margin({ top: 10 })
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)



      }
    }.width('100%')
  }

  subscriber: commonEventManager.CommonEventSubscriber | null = null

  //创建
  createSubscribeCommonEvent() {
    let subscribeInfo: commonEventManager.CommonEventSubscribeInfo = {
      events: [FLAG_COMMON_EVENT_NAME,
        commonEventManager.Support.COMMON_EVENT_BATTERY_CHANGED,
        commonEventManager.Support.COMMON_EVENT_POWER_CONNECTED,
        commonEventManager.Support.COMMON_EVENT_POWER_DISCONNECTED]
    }
    commonEventManager.createSubscriber(subscribeInfo,
      (error: BusinessError, data: commonEventManager.CommonEventSubscriber) => {
        if (error) {
          ToastUtils.show('创建失败：' + error.message)
          return
        }
        //成功创建
        this.subscriber = data
        ToastUtils.show('订阅成功')
      })

  }

  //订阅
  subscribeCommonEvent() {
    if (this.subscriber !== null) {
      commonEventManager.subscribe(this.subscriber,
        (error: BusinessError, data: commonEventManager.CommonEventData) => {
          if (error) {
            ToastUtils.show('订阅失败：' + error.message)
            return
          }
          // data.event 当前接收的公共事件名称
          // data.code 表示公共事件的结果代码，用于传递int类型的数据。
          // data.bundleName 包名 当前默认为空
          // data.data 表示公共事件的自定义结果数据，用于传递string类型的数据
          // data.parameters 公共事件的附加参数
          ToastUtils.show(JSON.stringify(data), 5000, Alignment.Center)
        })
    } else {
      ToastUtils.show('请先创建subscribe')
    }
  }

  //取消订阅
  unsubscribeCommonEvent() {
    if (this.subscriber !== null) {
      commonEventManager.unsubscribe(this.subscriber, (error: BusinessError) => {
        if (error) {
          ToastUtils.show('取消订阅失败：' + error.message)
          return
        }
        ToastUtils.show('取消订阅成功')
        this.subscriber = null
      })
    } else {
      ToastUtils.show('请先创建subscribe')
    }
  }

  //发布事件消息
  publishCommonEvent(isWithData: boolean) {
    if (isWithData) {
      let eventData: commonEventManager.CommonEventPublishData = {
        bundleName: 'com.zhq.harmonyosdemo', //订阅者的bundleName
        code: 10, //表示公共事件的结果代码
        data: '这是初始数据', //表示公共事件的自定义结果数据
        parameters: {
          //公共事件的附加信息
          "name": '张较瘦',
          "age": 18
        },
        isOrdered: false, //是否是有序事件
        isSticky: false, //是否是粘性事件
        // subscriberPermissions: []//订阅方应该具有的权限才能收到事件信息
      }
      commonEventManager.publish(FLAG_COMMON_EVENT_NAME, eventData, (error: BusinessError) => {
        if (error) {
          ToastUtils.show('发布携带信息事件失败：' + error.message)
          return
        }
        ToastUtils.show('发送携带信息公共事件成功')
      })
    } else {
      commonEventManager.publish(FLAG_COMMON_EVENT_NAME, (error: BusinessError) => {
        if (error) {
          ToastUtils.show('发布无信息事件失败：' + error.message)
          return
        }
        ToastUtils.show('发送无信息公共事件成功')
      })
    }

  }

  registerEmitter() {
    let event: emitter.InnerEvent = {
      eventId: FLAG_EMITTER_MSG,
      priority: emitter.EventPriority.IMMEDIATE//无需指定
    }
    let callback = (eventData: emitter.EventData): void => {
      let isUpdate = eventData.data?.['isUpdate'] as boolean
      if (isUpdate) {
        ToastUtils.show('收到消息')
      }
    }
    emitter.on(event, callback)
  }

  unregisterEmitter() {
    emitter.off(FLAG_EMITTER_MSG)
  }

  registerEventHub() {
    let eventHub = this.context.eventHub //获取eventHub
    eventHub.on(FLAG_EVENT_HUB_MSG, this.eventHubFunc)
    eventHub.on(FLAG_EVENT_HUB_MSG, (content: string) => {
      console.debug('===收到EventHub消息1：' + content)
    })
  }

  unregisterEventHub() {
    this.context.eventHub.off('event_1', (msg: string) => {
      console.debug('===取消订阅EventHub：event_1')
    })
  }
}

function jumpPageWithParams() {
  router.pushUrl({
    url: 'pages/Second',
    params: {
      id: 12,
      info: {
        name: '张三',
        age: 18
      }
    }
  }, router.RouterMode.Single, (error) => {

  })
}