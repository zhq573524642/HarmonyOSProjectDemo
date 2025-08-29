import { CommonButton } from '../component/MyComponent';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ObservedLinkPage {
  @State message: string = 'Hello World';
  //1.用于嵌套场景中实现双向数据同步
  //2.子组件中@ObjectLink装饰器装饰的状态变量用于接收@Observed装饰的类的实例，和父组件中对应的状态变量建立双向数据绑定。
  // 这个实例可以是数组中的被@Observed装饰的项，或者是class object中的属性，这个属性同样也需要被@Observed装饰。
  //3.@ObjectLink装饰的变量必须是被@Observed修饰的class实例
  //4.@ObjectLink不支持简单类型，简单类型可以使用@Prop
  //5.@ObjectLink的属性是可以改变的，但是变量的分配是不允许的，也就是说这个装饰器装饰变量是只读的，不能被改变。
  // this.classA.a =xxx是可以的，this.classA = xxx是不允许的
  //6.@ObjectLink装饰的变量和数据源的关系是双向同步，@ObjectLink装饰的变量相当于指向数据源的指针。
  //7.数据源可以是：@State、@Link、@Provide、@Consume、@ObjectLink
  //  可以初始化：@State、@Prop、@Link、@Provide
  //8.框架行为：class类实例被@Observed装饰，相当于给这个class包装了一个代理对象，代理这个类的属性的set和get；
  //当在子组件中创建@ObjectLink装饰的变量接收父组件的初始化， 会将自身注册到@Observed装饰的class实例上，也就是提供了个引用给class；
  //当@Observed装饰的class属性发生变化时，会执行到代理的setter和getter方法，然后遍历依赖它的@ObjectLink包装类，通知数据更新。
  //9.限制1：使用@Observed装饰class会改变class原始的原型链，@Observed和其他类装饰器装饰同一个class可能会带来问题
   //限制2：@ObjectLink装饰器不能在@Entry装饰的自定义组件中使用
   //限制3：@ObjectLink装饰的变量不能本地初始化，仅能通过构造参数从父组件传入初始值
  build() {
    Column() {
      CommonButton({ text: '嵌套内部数据是class' })
        .onClick(()=>{
           router.pushUrl({
             url:'pages/state/ObservedLinkClassPage'
           })
        })

      CommonButton({ text: '对象数组类型' })
        .onClick(()=>{
          router.pushUrl({
            url:'pages/state/ObservedLinkArrayPage'
          })
        })
    }
  }
}