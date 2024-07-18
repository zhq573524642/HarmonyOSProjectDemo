import { CommonButton } from '../component/MyComponent';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ObservedLinkPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      CommonButton({ text: 'Class类型' })
        .onClick(()=>{
           router.pushUrl({
             url:'pages/state/ObservedLinkClassPage'
           })
        })

      CommonButton({ text: 'Array类型' })
        .onClick(()=>{
          router.pushUrl({
            url:'pages/state/ObservedLinkArrayPage'
          })
        })
    }
  }
}