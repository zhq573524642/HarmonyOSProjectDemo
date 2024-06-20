import { CommonButton } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ArkTSBasePage {
  @State showBackParam: string = '页面返回参数在这里显示'

  build() {

    Column() {
      CommonButton({ text: '状态控制' })
        .onClick(() => {
          router.pushUrl({ url: 'pages/state/StateManagerPage' })
        })
      CommonButton({ text: '装饰器' })
        .onClick(() => {
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
