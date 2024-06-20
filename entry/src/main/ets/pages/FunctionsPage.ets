import { CommonButton, CommonTitle } from './component/MyComponent';
import { emitter } from '@kit.BasicServicesKit';
import { data } from '@kit.TelephonyKit';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct FunctionsPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      CommonTitle({ title: 'Emitter线程间通信' })
      Button('发送事件').onClick(() => {
        this.sendEvent()
      })
    }
    .width('100%')

  }

  aboutToAppear(): void {
    this.registerEvent()
  }

  aboutToDisappear(): void {
    this.unregisterEvent()
  }

  registerEvent() {
    // 定义一个eventId为1的事件
    let event: emitter.InnerEvent = {
      eventId: 1
    };
    // 收到eventId为1的事件后执行该回调
    let callBack = (eventData: emitter.EventData): void => {
      console.debug( `==当前页面：${JSON.stringify(eventData.data)}`)
      promptAction.showToast({ message: `当前页面：${JSON.stringify(eventData.data)}` })
    };
    // 订阅eventId为1的事件
    emitter.on(event, callBack)
  }

  unregisterEvent(){
    emitter.off(1)
  }

  sendEvent() {
    // 定义一个eventId为1的事件，事件优先级为Low
    let event: emitter.InnerEvent = {
      eventId: 1,
      priority: emitter.EventPriority.LOW
    };

    let eventData: emitter.EventData = {
      data: {
        content: 'c',
        id: 1,
        isEmpty: false
      }
    };

    // 发送eventId为1的事件，事件内容为eventData
    emitter.emit(event, eventData);
  }
}