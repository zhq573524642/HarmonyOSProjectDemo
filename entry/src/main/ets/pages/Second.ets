import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import { CommonButton } from './component/MyComponent';

@Entry
@Component
struct Second {
  private params: object = router.getParams();

  build() {
    Column() {
      Text('传来的参数：\n' +
      this.params?.['id'] + '\n' +
      this.params?.['info']?.['name'] + '\n' +
      this.params?.['info']?.['age'])
        .fontSize(15)
        .fontColor(Color.Black)
      CommonButton({ text: '返回Index页面并携带参数' })
        .onClick(() => {
          router.back({
            url: 'pages/Index',
            params: {
              name: '返回携带的参数'
            }
          })
        })
      CommonButton({ text: '返回页面增加系统提示框' })
        .onClick(() => {
          try {
            router.showAlertBeforeBackPage({
              message: '是否要返回？'
            })
          } catch (e) {
            console.debug('====返回错误' + e)
          }
          router.back() //必须加这句
        })
      CommonButton({ text: '返回页面自定义弹窗' })
        .onClick(() => {
          promptAction.showDialog({
            title:'温馨提示',
            message: '确定要返回吗？',
            buttons: [
              {
                text: '取消',
                color: '#00ff00'
              },
              {
                text: '确定',
                color: '#ff00ff'
              }
            ]
          }).then((result) => {
            if (result.index == 0) {
              console.info('===点击了取消')
            } else if (result.index == 1) {
              router.back()
            }
          }).catch((error) => {
            console.info('===错误' + error)
          })
        })
    }.height('100%')
    .width('100%')
  }
}