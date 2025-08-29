@Entry
@Component
struct StaticWidgetCard {

  build() {
  Column(){
    Text('静态卡片')
      .fontColor(Color.Black)
      .fontWeight(FontWeight.Bold)
      .fontSize('20fp')
    Row() {
      FormLink({
        action: 'router',
        abilityName: 'EntryAbility',
        bundleName:'com.zhq.harmonyosdemo',
        params: {
          title:'这是静态卡片-router',
          message: '消息消息消息消息'
        }
      }) {
        Column() {
          Image($r('app.media.img1'))
            .width('100%')
            .aspectRatio(1)
          Text('标题1')
            .fontColor(Color.Red)
            .fontSize('17fp')
            .margin('10vp')
            .fontWeight(FontWeight.Medium)
          Text('详情111111111111111111')
            .maxLines(2)
            .fontSize('13fp')
            .fontColor(Color.Gray)
        }
      }.height('100%')
      .layoutWeight(1)

      FormLink({
        action: 'message',
        abilityName: 'EntryAbility',
        params: {
          title:'这是静态卡片-message',
          message: '消息消息消息消息'
        }
      }) {
        Column() {
          Image($r('app.media.img2'))
            .width('100%')
            .aspectRatio(1)
          Text('标题2')
            .fontColor(Color.Yellow)
            .fontSize('17fp')
            .margin('10vp')
            .fontWeight(FontWeight.Medium)
          Text('详情222222222222222222')
            .maxLines(2)
            .fontSize('13fp')
            .fontColor(Color.Gray)
        }
      }.height('100%')
      .layoutWeight(1)

      FormLink({
        action: "call",
        abilityName: "EntryAbility",
        params: {
          'method':'functionFromWidgetCard',
          'title':'这是静态卡片-call',
          'num':123456
        }
      }) {
        Column() {
          Image($r('app.media.img3'))
            .width('100%')
            .aspectRatio(1)
          Text('标题3')
            .fontColor(Color.Green)
            .fontSize('17fp')
            .margin('10vp')
            .fontWeight(FontWeight.Medium)
          Text('详情33333333333333333333')
            .maxLines(2)
            .fontSize('13fp')
            .fontColor(Color.Gray)
        }
      }.height('100%')
      .layoutWeight(1)
    }
  }

  }
}