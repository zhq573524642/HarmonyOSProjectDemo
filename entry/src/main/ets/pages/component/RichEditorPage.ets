import { RouterUtil } from '@ohos/common/src/main/ets/utils/RouterUtil'
import { CommonTitle } from './MyComponent'

@Entry({ routeName: 'RichEditorPage' })
@Component
export struct RichEditorPage {
  static startPage() {
    RouterUtil.pushNamedRoute('RichEditorPage')
  }

  htmlStr: string =
    '<p>在framework的代码中，经常看到如下的权限检测的代码：</p>\\r\\n<p><img src=\\"https://wanandroid.com/blogimgs/af042353-c7c6-4f29-a988-3ad9b369964d.png\\" alt=\\"q1.png\\" /></p>\\r\\n<p><img src=\\"https://wanandroid.com/blogimgs/01fdb9cf-6f44-48bf-aa48-0cd527bfebd0.png\\" alt=\\"q2.png\\" /></p>\\r\\n<p>Binder.getCallingUid()字面理解是获取调用方的uid，但是这个代码是目标进程调用的，如何通过一个静态方法调用，就拿到调用方的uid呢？</p>'
  controller: RichEditorController = new RichEditorController()
  options: RichEditorOptions = { controller: this.controller }

  build() {
    Scroll() {
      Column() {
        CommonTitle({ title: '创建不使用属性字符串构建的RichEditor组件' })
        RichEditor(this.options)
          .onReady(() => {
            this.controller.addTextSpan(this.htmlStr, {
              style: {
                fontColor: Color.Red,
                fontSize: 14,
                fontWeight:FontWeight.Normal,
                fontStyle:FontStyle.Italic
              }
            })
          })
      }.width('100%')
    }.width('100%')
    .height('100%')
  }
}