import { CommonButton } from '../component/MyComponent';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ObservedLinkPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      CommonButton({ text: '嵌套对象类型' })
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