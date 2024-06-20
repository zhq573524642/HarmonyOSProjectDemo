import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = '从Entry HAP包跳转过来的';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('返回')
          .onClick(() => {
            router.back({
               url:'pages/Index'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}