import { Square } from '../component/MyComponent'
import { router } from '@kit.ArkUI'
import { PageRouter } from '../../router/PageRouter'

@Entry({ routeName: PageRouter.PAGE_RELATIVE_CONTAINER })
@Component
export struct RelativeContainerPage {
  static startPage() {
    router.pushNamedRoute({
      name: PageRouter.PAGE_RELATIVE_CONTAINER
    }, router.RouterMode.Single)
  }

  build() {
    //未设置id的子元素不会在相对布局中显示
    RelativeContainer() {
      Square({
        text: 'item1',
        color: Color.Red,
        w: 50,
        h: 50
      })
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          left: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .id('square1')
      Square({
        text: 'item2',
        color: Color.Yellow,
        w: 50,
        h: 50
      })
        .alignRules({
          top: { anchor: 'square1', align: VerticalAlign.Bottom },
          left: { anchor: 'square1', align: HorizontalAlign.End }
        })
        .id('square2')
      Square({
        text: 'item3',
        color: Color.Green,
        w: 50,
        h: 50
      })
        .alignRules({
          top: { anchor: 'square2', align: VerticalAlign.Center },
          left: { anchor: 'square2', align: HorizontalAlign.End }
        })
        .id('square3')
      Square({
        text: 'item4',
        color: Color.Pink,
        w: 50,
        h: 50
      })
        .alignRules({
          top: { anchor: 'square3', align: VerticalAlign.Bottom },
          left: { anchor: 'square1', align: HorizontalAlign.End }
        })
        .id('square4')

      Square({
        text: 'item5',
        color: Color.Blue,
        w: 100,
        h: 100
      })
        .alignRules({
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
          end: { anchor: '__container__', align: HorizontalAlign.End }
        })
        .id('square5')
      Square({
        text: 'item6',
        color: Color.Orange,
        w: 100,
        h: 100
      })
        .alignRules({
          bottom: { anchor: 'square5', align: VerticalAlign.Top },
          end: { anchor: 'square5', align: HorizontalAlign.Start }
        })
        .id('square6')

      Image($r('app.media.app_icon'))
        .width(80)
        .height(80)
        .id('image_icon')
        .alignRules({
          start: { anchor: '__container__', align: HorizontalAlign.Start },
          center: { anchor: '__container__', align: VerticalAlign.Center }
        })
        .margin({ left: 20 })
      Text('标题标题标题吧')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .id('text_name')
        .alignRules({
          start: { anchor: 'image_icon', align: HorizontalAlign.End },
          top: { anchor: 'image_icon', align: VerticalAlign.Top }
        })
        .margin({ left: 12 })
      Text('描述描述描述描述描述描述描述描述描述描述描述描述')
        .fontSize(13)
        .fontColor(Color.Black)
        .id('text_desc')
        .maxLines(2)
        .alignRules({
          start: { anchor: 'image_icon', align: HorizontalAlign.End },
          bottom: { anchor: 'image_icon', align: VerticalAlign.Bottom }
        })
        .margin({ left: 12 })



    }.width('100%')
    .height('100%')
    .backgroundColor('#e8e8e8')
  }
}