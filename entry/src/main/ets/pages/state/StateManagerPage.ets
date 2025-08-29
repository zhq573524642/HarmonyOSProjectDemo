import { CommonButton, CommonTitle } from '../component/MyComponent';
import { promptAction, router } from '@kit.ArkUI';
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils';

class TempClass {
  num: number

  constructor(num: number) {
    this.num = num
  }
}

AppStorage.setOrCreate<number>('param1', 40)
AppStorage.setOrCreate<TempClass>('param2', new TempClass(50))
AppStorage.setOrCreate<number>('freezeWhenInactiveValue', 1)

//@Entry内部组件树之间共享的LocalStorage
let param1: Record<string, number> = { 'param1': 10 };

let localStorage: LocalStorage = new LocalStorage(param1)

localStorage.setOrCreate('param2', new TempClass(20))

//从UIAbility共享的LocalStorage
let uiAbilityLocalStorage = LocalStorage.getShared()


PersistentStorage.persistProp<TempClass>('persistent_param', new TempClass(11))
PersistentStorage.persistProps([{
  key: "name",
  defaultValue: "aaa", //number | string | boolean | Object
}, {
  key: "age",
  defaultValue: 18
}])

@Entry({ storage: localStorage })
  //uiAbilityLocalStorage
@Component({ freezeWhenInactive: true })
struct StateManagerPage {
  private scroller: Scroller = new Scroller()
  @LocalStorageProp('param1') localStorageProp: number = 0
  @LocalStorageLink('param2') localStorageLink: TempClass = new TempClass(0)
  @LocalStorageLink('uiAbility_param') uiAbility_param: number = 0
  @State appStorage1: string = `AppStorage(param1)：${AppStorage.get<number>('param1')}`
  @State appStorage2: string = `AppStorage(param2)：${AppStorage.get<TempClass>('param2')?.num}`
  @StorageProp('param1') appStorageProp: number = 0
  @StorageLink('param2') appStorageLink: TempClass = new TempClass(0)
  @StorageLink('persistent_param') persistent_param: TempClass = new TempClass(0)
  @StorageLink('name') persistent_name: string = ""
  @State @Watch('updateText') textShow: string = 'abc'
  @State textInputShow: string = ''
  @StorageLink('freezeWhenInactiveValue') @Watch('freezeWhenInactiveValueChange') freezeWhenInactiveValue: number = 1
  uiContext: UIContext | undefined = undefined

  freezeWhenInactiveValueChange() {
    console.debug('===页面A--freezeWhenInactiveValueChange：' + this.freezeWhenInactiveValue)
  }

  build() {
    Scroll(this.scroller) {
      Column({ space: 8 }) {
        CommonTitle({ title: '组件的状态' })
        CommonButton({ text: '@State+@Link+@Prop' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/state/StatePropLinkPage'
            })
          })
        CommonButton({ text: '@Observed和@ObservedLink' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/state/ObservedLinkPage'
            })
          })
        CommonButton({ text: '@ObservedV2和@Trace' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/state/ObservedV2Page'
            })
          })
        CommonTitle({ title: 'class状态变量属性被@Track修饰' })
        Text('1.改变@Track修饰的变量使得绑定改属性的组件刷新，而不是整个class状态变量刷新')
        Text('2.包含@Track修饰的属性绑定在组件，其他未被@Track修饰的属性不可以用于绑定组件')
        CommonTitle({ title: 'ComponentV2' })
        CommonButton({ text: 'ComponentV2测试' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/state/ComponentV2Page'
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
        CommonTitle({ title: '自定义组件冻结功能' })
        Text('当前支持：页面路由router、TabContent、LazyForEach、Navigation')
        Text(`自定义组件冻结功能:${this.freezeWhenInactiveValue}`).fontSize(15).fontColor(Color.Red)
        Button('页面路由')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Second'
            })
          })

        Button('当前页面')
        CommonButton({ text: 'MVVM示例' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/mvvm/PageEntry'
            })
          })

        CommonTitle({ title: '应用的状态' })
        //1.LocalStorage 页面级UI状态存储
        //2.应用程序可以创建多个LocalStorage实例，LocalStorage实例可以在页面内共享，
        // 也可以通过getShared接口，实现跨页面、UIAbility实例内共享
        //3.除了根节点可通过@Entry来接收LocalStorage实例，自定义组件（子节点）也可以通过构造参数来传递LocalStorage实例
        //参数传递 （1）子组件定义了其他属性 初始化 childView({ xxx:xxx},localStorage);
        //（2）子组件没有定义其他属性 childView(localStorage)
        //（3）子组件定义了其他属性，但是不需要初始化该属性  childView({},localStorage)
        //4.@LocalStorageProp 单行同步关系，@LocalStorageLink 双向同步关系,其参数key必须为string，不支持Function类型的变量
        //5.LocalStorage是页面级存储，getShared接口仅能获取当前Stage通过windowStage.loadContent传入的LocalStorage实例
        CommonTitle({ title: '1.1:LocalStorage(一个@Entry中)' })

        Button('setOrCreate改变LocalStorage(param1)').onClick(() => {
          let old = localStorage.get<number>('param1')
          if (old) {
            localStorage.setOrCreate<number>('param1', old + 1)
          }
        })
        Button('setOrCreate改变LocalStorage(param2)').onClick(() => {
          let old = localStorage.get<TempClass>('param2')
          if (old) {
            localStorage.setOrCreate<TempClass>('param2', new TempClass(old.num + 1))
          }

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

        Text(`PersistentStorage.persistProp：组件内部接收：${this.persistent_param.num}`)
          .fontSize(15)
          .fontColor(Color.Green)
        Text(`PersistentStorage.persistProps：组件内部接收：${this.persistent_name}`)
          .fontSize(15)
          .fontColor(Color.Green)
        Text(`PersistentStorage：AppStorage获取：${AppStorage.get<TempClass>('persistent_param')?.num}`)
          .fontSize(15)
          .fontColor(Color.Red)
        Button('改变StorageLink以改变PersistentStorage').onClick(() => {
          this.persistent_param.num += 1
        })


        Button('删除PersistentStorage').onClick(() => {
          PersistentStorage.deleteProp('persistent_param')
        })

        CommonTitle({ title: '4:Environment设备环境参数' })
        Button('accessibilityEnabled')
          .onClick(() => {
            ToastUtils.show('无障碍是否开启：' + this.accessibilityEnabled)
          })
        Button('colorMode')
          .onClick(() => {
            ToastUtils.show('色彩模型类型：' + this.colorMode.toString())
          })

      }.width('100%')
    }.width('100%')
    .scrollable(ScrollDirection.Vertical)

  }

  @StorageProp('accessibilityEnabled') accessibilityEnabled: boolean = false
  @StorageProp('colorMode') colorMode: ColorMode = ColorMode.LIGHT

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

