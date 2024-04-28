import router from '@ohos.router'
import { CommonButton, StateTestView } from './component/MyComponent'

@Entry
@Component
struct StateTestPage {
  @State stateParam: string = 'stateParam_传入'
  @State linkParam: string = 'linkParam_传入'
  @State propParam: string = 'propParam_传入'

  build() {
    Column() {
      Text('stateParam：' + this.stateParam).fontSize(16)
      Text('linkParam：' + this.linkParam).fontSize(16)
      Text('propParam：' + this.propParam).fontSize(16)
      CommonButton({ text: '点击' })
        .onClick(() => {
          this.stateParam = 'stateParam_传入_点击'
          this.linkParam = 'linkParam_传入_点击'
          this.propParam = 'propParam_传入_点击'
        })
      StateTestView({ stateParam: this.stateParam, linkParam: $linkParam, propParam: this.propParam })
      CommonButton({text:'查看文档'})
        .onClick(()=>{
           router.pushUrl({
             url:'pages/web/WebPage',
             params:{
                web_url:'https://www.runoob.com/typescript/ts-array.html'
             }
           })
        })
    }
  }
}