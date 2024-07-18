import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'
import { UIAbility, common } from '@kit.AbilityKit'

@Entry
@Component
struct ArkTSBasePage {
  @State showBackParam: string = '页面返回参数在这里显示'
  private context = getContext(this) as common.UIAbilityContext

  build() {

    Column() {
      CommonButton({ text: '数据结构' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/data/DataStructurePage'
          })
        })
      CommonButton({ text: '状态控制' })
        .onClick(() => {
          router.pushUrl({ url: 'pages/state/StateManagerPage' })
        })
      CommonButton({ text: '装饰器' })
        .onClick(() => {
          // this.context.currentHapModuleInfo.
          router.pushUrl({
            url: 'pages/decorator/ArkDecoratorPage'
          })
        })

      Text(`页面跳转回传参数：${this.showBackParam}`)
        .margin(8)
        .fontSize(15)
      CommonButton({ text: 'router页面跳转并传递参数' })
        .onClick(() => {
          jumpPageWithParams()
        })
      CommonTitle({ title: '应用程序包' })
      CommonButton({ text: 'HAR（静态共享包）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ui/arkts/HarLibPage'
          })
        })
      CommonButton({ text: 'HSP（动态共享包）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ui/arkts/HspLibPage'
          })
        })
      CommonButton({ text: 'UIAbility' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/ui/arkts/AbilityTestPage'
          })
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)

  }
}

class Person {
  name: string = '';
  age: number = 0;
}

class Student {
  id: number = 0;
  info: Person = new Person();
}

function jumpPageWithParams() {
  let student: Student = {
    id: 12,
    info: {
      name: '张三',
      age: 18
    }
  }

  router.pushUrl({
    url: 'pages/Second',
    params: student
  }, router.RouterMode.Single, (error) => {

  })
}
