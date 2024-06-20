import { CommonButton, CommonTitle } from '../component/MyComponent';
import { promptAction, router } from '@kit.ArkUI';

class TempClass {
  num: number

  constructor(num: number) {
    this.num = num
  }
}

AppStorage.setOrCreate<number>('param1', 40)
AppStorage.setOrCreate<TempClass>('param2', new TempClass(50))

//@Entry内部组件树之间共享的LocalStorage
let param1: Record<string, number> = { 'param1': 10 };

let localStorage: LocalStorage = new LocalStorage(param1)

localStorage.setOrCreate('param2', new TempClass(20))

//从UIAbility共享的LocalStorage
let uiAbilityLocalStorage = LocalStorage.getShared()

PersistentStorage.persistProp<TempClass>('persistent_param', new TempClass(11))

@Entry(localStorage)
  //uiAbilityLocalStorage
@Component
struct StateManagerPage {
  private scroller: Scroller = new Scroller()
  @LocalStorageProp('param1') localStorageProp: number = 0
  @LocalStorageLink('param2') localStorageLink: TempClass = new TempClass(0)
  @LocalStorageLink('uiAbility_param') uiAbility_param: number = 0
  @State localStorage1: string = `LocalStorage(param1)：${localStorage.get<number>('param1')}`
  @State localStorage2: string = `LocalStorage(param2)：${localStorage.get<TempClass>('param2')?.num}`
  @State appStorage1: string = `AppStorage(param1)：${AppStorage.get<number>('param1')}`
  @State appStorage2: string = `AppStorage(param2)：${AppStorage.get<TempClass>('param2')?.num}`
  @StorageProp('param1') appStorageProp: number = 0
  @StorageLink('param2') appStorageLink: TempClass = new TempClass(0)
  @StorageLink('persistent_param') persistent_param: TempClass = new TempClass(0)
  @State @Watch('updateText') textShow: string = 'abc'
  @State textInputShow: string = ''

  build() {

    Scroll(this.scroller) {
      Column({ space: 15 }) {
        CommonTitle({ title: '组件的状态' })
        CommonButton({ text: '@State' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/state/StatePage'
            })
          })
        CommonButton({ text: '@Prop' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/state/PropPage'
            })
          })

        CommonTitle({ title: '@Watch装饰器：状态变量更改通知' })
        Text(this.textShow).fontSize(15).fontColor(Color.Orange)
        Button('修改@Watch修饰的状态变量')
          .onClick(() => {
            this.textShow = 'bca'
          })
        CommonTitle({ title: '$$内置组件双向同步' })
        Text(this.textInputShow).fontSize(15).fontColor(Color.Red)
        TextInput({
          text: $$this.textInputShow,
          placeholder: '请输入'
        })
          .fontSize(15)
          .fontColor(Color.Green)
          .width('70%')
          .placeholderColor(Color.Gray)
          .caretColor(Color.Orange)
          .textAlign(TextAlign.Center)
          .height(50)
        CommonButton({ text: 'MVVM示例' })
          .onClick(() => {
            router.pushUrl({
              url:'pages/mvvm/PageEntry'
            })
          })

        CommonTitle({ title: '应用的状态' })
        CommonTitle({ title: '1.1:LocalStorage(一个@Entry中)' })
        Text(this.localStorage1)
          .fontSize(15)
          .fontColor(Color.Black)
        Text(this.localStorage2)
          .fontSize(15)
          .fontColor(Color.Black)


        Button('刷新LocalStorage').onClick(() => {
          this.localStorage1 = `LocalStorage(param1)：${localStorage.get<number>('param1')}`
          this.localStorage2 = `LocalStorage(param2)：${localStorage.get<TempClass>('param2')?.num}`
        })
        Button('改变LocalStorage(param1)').onClick(() => {
          localStorage.setOrCreate<number>('param1', 66)
        })
        Button('改变LocalStorage(param2)').onClick(() => {
          localStorage.setOrCreate<TempClass>('param2', new TempClass(88))
        })
        Text(`父LocalStorageProp(param1)：${this.localStorageProp}`)
          .fontSize(15)
          .fontColor(Color.Black)

        Text(`父LocalStorageLink(param2)：${this.localStorageLink.num}`)
          .fontSize(15)
          .fontColor(Color.Black)

        Button('父中改变LocalStorageProp').onClick(() => {
          this.localStorageProp += 1
        })
        Button('父中改变LocalStorageLink').onClick(() => {
          this.localStorageLink.num += 1
        })
        ChildView()

        CommonTitle({ title: '1.2:LocalStorage(从UIAbility共享一个或多个视图)' })
        Text(`UIAbility共享的LocalStorage：${this.uiAbility_param}`)
          .fontSize(15)
          .fontColor(Color.Green)

        CommonTitle({ title: '2:AppStorage' })

        Text(this.appStorage1)
          .fontSize(15)
          .fontColor(Color.Black)
        Text(this.appStorage2)
          .fontSize(15)
          .fontColor(Color.Black)


        Button('刷新AppStorage').onClick(() => {
          this.appStorage1 = `AppStorage(param1)：${AppStorage.get<number>('param1')}`
          this.appStorage2 = `AppStorage(param2)：${AppStorage.get<TempClass>('param2')?.num}`
        })
        Button('改变AppStorage(param1)').onClick(() => {
          AppStorage.setOrCreate<number>('param1', 100)
        })
        Button('改变AppStorage(param2)').onClick(() => {
          AppStorage.setOrCreate<TempClass>('param2', new TempClass(200))
        })

        Text(`AppStorageProp(param1)：${this.appStorageProp}`)
          .fontSize(15)
          .fontColor(Color.Green)
        Text(`AppStorageLink(param2)：${this.appStorageLink.num}`)
          .fontSize(15)
          .fontColor(Color.Green)
        Button('改变AppStorageProp').onClick(() => {
          this.appStorageProp += 1
        })
        Button('改变AppStorageLink').onClick(() => {
          this.appStorageLink.num += 1
        })
        Button('打印逻辑中的Storage数据').onClick(() => {
          this.getStorageData()
        })
        CommonTitle({ title: '3:PersistentStorage：持久化存储UI状态' })

        Text(`PersistentStorage关联的AppStorage：${this.persistent_param.num}`)
          .fontSize(15)
          .fontColor(Color.Green)
        Button('改变StorageLink以改变PersistentStorage').onClick(() => {
          this.persistent_param.num += 1
        })

        Button('删除PersistentStorage').onClick(() => {
          PersistentStorage.deleteProp('persistent_param')
        })

      }.width('100%')
    }.width('100%')
    .scrollable(ScrollDirection.Vertical)

  }

  updateText(propName: string) {
    promptAction.showToast({ message: `更新了${propName}:${this.textShow}` })
  }

  getStorageData() {
    let localPropParam1: SubscribedAbstractProperty<number> = localStorage.prop('param1')
    let localLinkParam2: SubscribedAbstractProperty<TempClass> = localStorage.link('param2')
    let appPropParam1: SubscribedAbstractProperty<number> = AppStorage.prop('param1')
    let appLinkParam2: SubscribedAbstractProperty<TempClass> = AppStorage.link('param2')
    console.debug(`===localPropParam1:${localPropParam1.get()}--localLinkParam2:${localLinkParam2.get()
      .num}--appPropParam1:${appPropParam1.get()}--appLinkParam2:${appLinkParam2.get().num}`)
  }
}

@Component
struct ChildView {
  @LocalStorageProp('param1') localStorageProp: number = 0
  @LocalStorageLink('param2') localStorageLink: TempClass = new TempClass(0)

  build() {
    Column() {
      Text(`子LocalStorageProp(param1)：${this.localStorageProp}`)
        .fontSize(15).fontColor(Color.Red).margin({ top: 15 })
      Text(`子LocalStorageLink(param2)：${this.localStorageLink.num}`)
        .fontSize(15)
        .fontColor(Color.Red)
        .margin({ top: 15 })
      Button('子中改变LocalStorageProp').onClick(() => {
        this.localStorageProp++
      }).margin({ top: 15 })
      Button('子中改变LocalStorageLink').onClick(() => {
        this.localStorageLink.num++
      }).margin({ top: 15 })
    }
  }
}

