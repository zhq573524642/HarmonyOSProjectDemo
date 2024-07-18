import { CommonTitle } from '../../component/MyComponent'

@Entry
@Component
struct CommonPropertyPage {
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column({ space: 8 }) {
        //尺寸属性
        CommonTitle({ title: '1.尺寸属性' })
        //1.未设置宽高
        Text('文本1').fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.Orange)
        Text('文本2').fontSize(15)
          .fontColor(Color.Black)// .width('80%')//所占比例
            // .width('80px')
          .width(80)//默认vp
          .backgroundColor(Color.Orange)
        //size
        Text('文本3').fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.Orange)
          .size({ width: 80, height: 80 })
        CommonTitle({ title: '位置属性' })
        Column() {
          Text('文本文本1')
            .fontSize(15)
        }.width(150)
        .height(150)
        .backgroundColor(Color.Pink)

        Column() {
          Text('文本文本2')
            .fontSize(15)
            .position({ x: 40, y: 40 })
        }.width(150)
        .height(150)
        .backgroundColor(Color.Pink)

        Column() {
          Text('文本文本3')
            .fontSize(15)
            .position({ x: 40, y: 40 })
            .markAnchor({ x: 20, y: 20 })
        }.width(150)
        .height(150)
        .backgroundColor(Color.Pink)

        Column() {
          Text('文本文本4')
            .fontSize(15)
            .offset({ left: 40, top: 40 })
        }
        .width(150)
        .height(150)
        .backgroundColor(Color.Pink)

        Column() {
          Text('文本文本5')
            .fontSize(15)
            .offset({ right: -40, bottom: -40 })
        }.width(150)
        .height(150)
        .backgroundColor(Color.Pink)
      }.width('100%')
    }.width('100%')
  }
}