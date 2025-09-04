import { CommonTitle } from '../component/MyComponent'
import { AppStorageV2, PersistenceV2, Type } from '@kit.ArkUI';
import { ComponentV2SecondPage } from './ComponentV2SecondPage';
import { ToastUtils } from '@ohos/common';

@ObservedV2
export class Person1 {
  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  id: number = 0
  @Trace
  name: string = ''
  @Trace
  age: number = 0
  isSelected: boolean = false
}

@ObservedV2
export class StudentClass {
  @Trace
  person: Person1 = new Person1('', 0)
  @Trace
  name: string = '姓名：初始化';
  @Trace
  age: number = 0

  //监听被@ObservedV2装饰的类的被@Trace装饰的属性
  @Monitor('name')
  onNameChanged(monitor: IMonitor) {
    let beforeValue: string = monitor.value()?.before as string
    let nowValue: string = monitor.value()?.now as string
  }

  //监听嵌套类的属性，嵌套类需要被@ObservedV2装饰，属性需要 被@Trace装饰
  @Monitor('person.name')
  onNameInPersonChanged(monitor: IMonitor) {

  }
}

@Entry
@ComponentV2
export struct ComponentV2Page {
  /**
   * 1.在@ComponentV2装饰的自定义组件中，开发者仅可以使用全新的状态变量装饰器，
   * 包括@Local、@Param、@Once、@Event、@Provider、@Consumer等。

   2.@ComponentV2装饰的自定义组件暂不支持组件复用、LocalStorage等现有自定义组件的能力。

   3.无法同时使用@ComponentV2与@Component装饰同一个struct结构。

   4.@ComponentV2支持一个可选的boolean类型参数freezeWhenInactive，来实现组件冻结功能。
   */

  /**
   * 以下不允许：
   *
   *1.@ComponentV2装饰的自定义组件中的非状态变量接收来自父组件传递的变量。

   2.将@State、@Prop、@Link、@ObjectLink、@Provide、@Consume、@StorageLink、@StorageProp、
   @LocalStorageLink、@LocalStorageProp等装饰的对象类型的变量传递给@ComponentV2装饰的自定义组件里的
   @Param、@Event等装饰的变量。

   3.将被@Local、@Param、@Event、@Provider、@Consumer等装饰的Array、Set、Map、Date类型的变量传递给@Component装饰的自定义组件里的@State、@Prop、@ObjectLink、@Provide等装饰的变量。

   4.在@Component装饰的自定义组件里被@Link修饰的变量，接收来自@ComponentV2装饰的父组件传递的变量。

   5.在@Component装饰的自定义组件中使用@State、@Prop、@Link、@Provide、@Consume、@StorageLink、@StorageProp、@LocalStorageLink、@LocalStorageProp装饰被@ObservedV2装饰的类。

   6.在@ComponentV2装饰的自定义组件中使用@Local、@Param、@Event、@Provider()、@Consumer()装饰被@Observed装饰的类。
   */
  //TODO @Local
  //1.@Local 被@Local装饰的变量无法从外部初始化，因此必须在组件内部进行初始化。
  //相当于@State，只不过只能在当前组件初始化，不支持父组件初始化
  //2.@Local装饰器只能在@ComponentV2装饰的自定义组件中使用。
  //3.当装饰简单类型（number、string、boolean）数组时，可以观察到数组整体或数组项的变化。
  @Local localCount: number = 2
  @Local textColor: ResourceColor = Color.Orange
  @Local studentClass: StudentClass = new StudentClass()
  @Provider('provider_name') providerName: string = '父组件初始值'
  @Local monitorLocalName1: string = '父组件初始值'
  @Local monitorLocalName2: string = '父组件初始值'
  @Local count: number = 1
  @Local doubleBindingValue: number = 5

  @Monitor('monitorLocalName1','monitorLocalName2')
  onMonitorChanged(monitor: IMonitor) {
    monitor.dirty.forEach((path: string) => {
      console.debug(`===父组件中：${path}改变：旧值:${monitor.value(path)?.before} -- 新值:${monitor.value(path)?.now}}`)
    })
  }

  scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        CommonTitle({ title: '@Local:组件内部状态\n@Param:组件外部输入\n@Once:初始化同步一次\n@Event:组件输出' })
        Text(`@Local：${this.localCount}`).fontSize(20).fontColor(Color.Green)
        TestParamComponent({ paramCount: this.localCount, paramClass: this.studentClass, onceCount: this.localCount })
        Button('点击改变@Local修饰的变量')
          .onClick(() => {
            this.localCount++
            this.studentClass.name = "姓名：" + this.localCount
          })

        TestEventComponent({
          paramColor: this.textColor, onChangeColor: (colorFlag: number) => {
            if (colorFlag == 1) {
              this.textColor = Color.Red
            } else {
              this.textColor = Color.Yellow
            }
          }
        })

        CommonTitle({ title: '@Provider和Consumer' })
        Text(this.providerName).fontSize(20).fontColor(Color.Pink)
        TestProviderAndConsumer()

        CommonTitle({ title: 'Monitor监听状态变量变化' })
        Text(this.monitorLocalName1).fontSize(20).fontColor(Color.Yellow)
        Text(this.monitorLocalName2).fontSize(20).fontColor(Color.Green)
        Line().height(10).backgroundColor(Color.Gray).width('80%')
        TestMonitor({ message1: this.monitorLocalName1, message2: this.monitorLocalName2 })
        Button('父组件点击修改monitorLocalName1')
          .onClick(() => {
            this.monitorLocalName1 = '父组件赋值1'
          })
        Button('父组件点击修改monitorLocalName2')
          .onClick(() => {
            this.monitorLocalName2 = '父组件赋值2'
          })

        CommonTitle({ title: '@Computed计算属性' })

        TestComputed({ count: this.count })
        Button(`父组件的值:${this.count}-点击修改`)
          .onClick(() => {
            this.count++
          })

        CommonTitle({ title: '!!语法：双向绑定' })
        Text(`双向绑定-父组件：${this.doubleBindingValue}`).fontSize(20).fontColor(Color.Green)
        Button('点击设置父组件value值')
          .onClick(() => {
            this.doubleBindingValue++
          })
        TestDoubleBinding({ value: this.doubleBindingValue!!})

        CommonTitle({ title: 'AppStorageV2: 应用全局UI状态存储' })
        TestAppStorageV2()

        CommonTitle({ title: 'PersistenceV2: 持久化储存UI状态' })
        TestPersistenceV2()

      }.width('100%')
    }.width('100%')
    .height('100%')
    .scrollBar(BarState.Auto)
  }
}

@ComponentV2
struct TestParamComponent {
  //1.@Param表示组件从外部传入的状态，使得父子组件之间的数据能够进行同步：
  //2.@Param装饰的变量支持本地初始化，但不允许在组件内部直接修改。
  //3.被@Param装饰的变量能够在初始化自定义组件时从外部传入，当数据源也是状态变量时，数据源的修改会同步给@Param。
  //4.@Param可以接受任意类型的数据源，包括普通变量、状态变量、常量、函数返回值等。
  //5.@Param装饰的变量变化时，会刷新该变量关联的组件。
  //6.@Param支持观测number、boolean、string、Object、class等基本类型以及Array、Set、Map、Date等内嵌类型。
  //7.对于复杂类型如类对象，@Param会接受数据源的引用。在组件内可以修改类对象中的属性，该修改会同步到数据源。
  //8.@Param的观测能力仅限于被装饰的变量本身。当装饰简单类型时，可以观测变量的整体改变。当装饰对象类型时，仅能观测对象整体的改变。当装饰数组类型时，可以观测数组整体和元素项的改变。当装饰Array、Set、Map、Date等内嵌类型时，可以观测到通过API调用带来的变化。详见观察变化。
  //9.@Param支持null、undefined以及联合类型。
  //10.允许本地初始化，若不在本地初始化，则需要和@Require装饰器一起使用，要求必须从外部传入初始化。
  @Require
  @Param paramCount: number
  @Require
  @Param paramClass: StudentClass
  //1.@Once装饰器仅在变量初始化时接受外部传入值进行初始化，当后续数据源更改时，不会将修改同步给子组件。
  //2.@Once只能用在@ComponentV2装饰的自定义组件中且仅能与@Param搭配使用。
  //3.@Once不影响@Param的观测能力，仅针对数据源的变化做拦截。
  //4.@Once与@Param装饰变量的先后顺序不影响实际功能。
  //5.@Once与@Param搭配使用时，可以在本地修改@Param变量的值。
  @Require
  @Once
  @Param onceCount: number

  build() {
    Column({ space: 10 }) {
      Text(`@Require/@Param-基本类型数据：${this.paramCount}`).fontSize(20).fontColor(Color.Red)
      Text(`@Require/@Param-Object：${this.paramClass.name}`).fontSize(20).fontColor(Color.Green)
      Text(`@Require/@Once/@Param：${this.onceCount}`).fontSize(20).fontColor(Color.Blue)
      Button('修改@Once/@Param的值')
        .onClick(() => {
          // this.paramCount++  错误：@Param不能在子组件内部直接修改
          this.onceCount++
          this.paramClass.name = "子组件内修改姓名：" + this.paramCount
        })
    }
  }
}

@ComponentV2
struct TestEventComponent {
  //1.@Param装饰的变量不能本地修改，通过@Event可间接实现：
  //由于@Param装饰的变量在本地无法更改，使用@Event装饰器装饰回调方法并调用，可以实现更改数据源的变量，
  //再通过@Local的同步机制，将修改同步回@Param，以此达到主动更新@Param装饰变量的效果。

  @Require
  @Param paramColor: ResourceColor
  @Event onChangeColor: (colorFlag: number) => void = (colorFlag: number) => {
  }

  build() {
    Column({ space: 10 }) {
      Text('@Event输出回调@Local修改，同步更新@Param').fontSize(20).fontColor(this.paramColor)
      Row() {
        Button('点击修改文本颜色:红色').onClick(() => {
          this.onChangeColor?.(1)
        })
        Button('点击修改文本颜色:黄色').onClick(() => {
          this.onChangeColor?.(2)
        })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }.width('100%')
  }
}

@ComponentV2
struct TestProviderAndConsumer {
  @Consumer('provider_name') consumerName: string = '子组件初始值'

  build() {
    Column({ space: 10 }) {
      Text(this.consumerName).fontSize(20).fontColor(Color.Brown)
      Button('点击改变')
        .onClick(() => {
          this.consumerName = '子组件修改了值'
        })
    }
  }
}

@ComponentV2
struct TestMonitor {
  //1.@Monitor装饰器支持在@ComponentV2装饰的自定义组件中使用，未被状态变量装饰器@Local、@Param、@Provider、@Consumer、@Computed装饰的变量无法被@Monitor监听到变化。
  //2. @Monitor装饰器支持在类中与@ObservedV2、@Trace配合使用，不允许在未被@ObservedV2装饰的类中使用@Monitor装饰器。未被@Trace装饰的属性无法被@Monitor监听到变化。
  //3.当观测的属性变化时，@Monitor装饰器定义的回调方法将被调用。判断属性是否变化使用的是严格相等（===），当严格相等判断的结果是false（即不相等）的情况下，
  // 就会触发@Monitor的回调。当在一次事件中多次改变同一个属性时，将会使用初始值和最终值进行比较以判断是否变化。
  //4.单个@Monitor装饰器能够同时监听多个属性的变化，当这些属性在一次事件中共同变化时，只会触发一次@Monitor的回调方法。
  //5.@Monitor装饰器具有深度监听的能力，能够监听嵌套类、多维数组、对象数组中指定项的变化。对于嵌套类、对象数组中成员属性变化的监听要求该类被@ObservedV2装饰且该属性被@Trace装饰。
  //6.在继承类场景中，可以在父子组件中对同一个属性分别定义@Monitor进行监听，当属性变化时，父子组件中定义的@Monitor回调均会被调用。
  //7.和@Watch装饰器类似，开发者需要自己定义回调函数，区别在于@Watch装饰器将函数名作为参数，而@Monitor直接装饰回调函数。
  //8.@Monitor支持对数组中的项进行监听，包括多维数组，对象数组。@Monitor无法监听内置类型（Array、Map、Date、Set）的API调用引起的变化。当@Monitor监听数组整体时，
  //只能观测到数组整体的赋值。可以通过监听数组的长度变化来判断数组是否有插入、删除等变化。当前仅支持使用"."的方式表达深层属性、数组项的监听。
  //9.在一次事件中多次改变被@Monitor监听的属性，以最后一次修改为准。
  //10.当一个类中存在对一个属性的多次监听时，只有最后一个定义的监听方法会生效。
  //11.@Monitor的参数需要为监听属性名的字符串，仅可以使用字符串字面量、const常量、enum枚举值作为参数。
  //如果使用变量作为参数，仅会监听@Monitor初始化时，变量值所对应的属性。当更改变量时，@Monitor无法实时改变监听的属性，即@Monitor监听的目标属性从初始化时便已经确定，无法动态更改。
  //12.建议开发者避免在@Monitor中再次更改被监听的属性，这会导致无限循环。
  //13.当@Monitor定义在@ComponentV2装饰的自定义组件中时，@Monitor会在状态变量初始化完成之后生效，并在组件销毁时失效。
  //   当@Monitor定义在@ObservedV2装饰的类中时，@Monitor会在类的实例创建完成后生效，在类的实例销毁时失效。
  //方法：（1）将@Monitor定义在自定义组件中。（2）主动置空监听的对象。
  @Require
  @Once
  @Param message1: string = '子组件初始值-message1'
  @Require
  @Param message2: string = '子组件初始值-message2'

  @Monitor('message1','message2')
  onMessageChanged(monitor: IMonitor) {
    monitor.dirty.forEach((path: string) => {
      console.debug(`===子组件中：${path}改变：旧值:${monitor.value(path)?.before} -- 新值:${monitor.value(path)?.now}}`)
    })
  }

  build() {
    Column({ space: 10 }) {
      Text(this.message1).fontSize(20).fontColor(Color.Brown)
      Text(this.message2).fontSize(20).fontColor(Color.Orange)
      Button('子组件点击改变-message1')
        .onClick(() => {
          this.message1 = '子组件修改了值-message1'
        })
    }
  }
}

@ComponentV2
struct TestComputed {
  //1.当开发者使用相同的计算逻辑重复绑定在UI上时，为了防止重复计算，可以使用@Computed计算属性。
  // 计算属性中的依赖的状态变量变化时，只会计算一次。这解决了UI多次重用该属性导致的重复计算和性能问题。
  //2.对于简单计算，不建议使用计算属性，因为计算属性本身也有开销。对于复杂的计算，@Computed能带来性能收益。
  //3.@ComponentV2中的@Computed会在自定义组件创建的时候初始化，触发@Computed计算。
  //@ObservedV2装饰的类中的@Computed，会在@ObservedV2装饰的类实例创建后，异步初始化，触发@Computed计算。
  //4.不可在@Computed中做其他冗余的逻辑，在@Computed装饰的getter方法中，不能改变参与计算的属性，以防止重复执行计算属性导致的appfreeze。
  //5.@Computed不能和双向绑定!!连用，@Computed装饰的是getter访问器，不会被子组件同步，也不能被赋值。
  //6.@Computed为状态管理V2提供的能力，只能在@ComponentV2和@ObservedV2中使用。
  //7.多个@Computed一起使用时，警惕循环求解，以防止计算过程中的死循环
  //8.@Computed装饰的属性可以被@Monitor监听变化
  //9.@Computed装饰的属性可以初始化@Param
  @Require
  @Param count: number

  @Computed
  get getCount(): number {
    return this.count * 2
  }

  build() {
    Column() {
      Text(`父组件传的值*2=count:${this.getCount}`).fontSize(20)
    }
  }
}

@ComponentV2
struct TestDoubleBinding {
  //双向绑定
  @Param value: number = 10
  //@Event方法名需要声明为“$”+ @Param属性名
  @Event $value: (num: number) => void = (num: number) => {
  }

  build() {
    Column({ space: 10 }) {
      Text('双向绑定-子组件' + this.value).fontSize(20).fontColor(Color.Red)
      Button('点击设置子组件value值')
        .onClick(() => {
          let value = this.value + 1;
          this.$value(value)
        })
    }
  }
}

@ComponentV2
struct TestAppStorageV2 {
  //需要配合UI使用（UI线程），不能在其他线程使用，如不支持@Sendable。
  //不支持collections.Set、collections.Map等类型。
  //不支持非buildin类型，如PixelMap、NativePointer、ArrayList等Native类型。
  //不支持存储基本类型，如string、number、boolean等。
  @Local appStorageV2Value1: StudentClass
    = AppStorageV2.connect<StudentClass>(StudentClass, 'student1', () => new StudentClass())!
  @Local appStorageV2Value2: StudentClass
    = AppStorageV2.connect<StudentClass>(StudentClass, 'student2', () => new StudentClass())!

  build() {
    Column({ space: 10 }) {
      Text(`key:student1中age属性的值：${this.appStorageV2Value1.age}`).fontSize(18).fontColor(Color.Brown)
      Text(`key:student2中age属性的值：${this.appStorageV2Value2.age}`).fontSize(18).fontColor(Color.Orange)
      Text(`所有的key：${AppStorageV2.keys()}`).fontSize(18).fontColor(Color.Orange)
      Button('跳转页面修改值')
        .onClick(() => {
          ComponentV2SecondPage.startPage()
        })
    }
  }
}

@ComponentV2
struct TestPersistenceV2 {
  @Local persistenceV2Value: StudentClass = PersistenceV2.connect(StudentClass, 'p_student', () => new StudentClass())!

  build() {
    Column({ space: 10 }) {
      Text(`key:p_student中studentClass.person.age属性的值：${this.persistenceV2Value.person.age}`)
        .fontSize(18)
        .fontColor(Color.Blue)
      Text(`所有的key：${PersistenceV2.keys()}`).fontSize(18).fontColor(Color.Orange)
      Button('跳转页面修改值')
        .onClick(() => {
          ComponentV2SecondPage.startPage()
        })
    }
  }
}