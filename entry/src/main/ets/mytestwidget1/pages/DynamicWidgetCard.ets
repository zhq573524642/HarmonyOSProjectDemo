let localStorage = new LocalStorage()

@Entry(localStorage)
@Component
struct DynamicWidgetCard {
  @LocalStorageProp('title') title: ResourceStr = '默认的标题';
  @LocalStorageProp('detail') detail: ResourceStr = '默认的详情';

  build() {
    Column() {
      Text('动态卡片')
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .margin({top:15})
        .fontSize('20fp')
      Row() {
        Column() {
          Image($r('app.media.img1'))
            .width('100%')
            .aspectRatio(1)
          Text(this.title)
            .fontColor(Color.Red)
            .fontSize('17fp')
            .margin('10vp')
            .fontWeight(FontWeight.Medium)
          Text(this.detail)
            .maxLines(2)
            .fontSize('13fp')
            .fontColor(Color.Gray)

        }.height('100%')
        .layoutWeight(1)
        .onClick(() => {
          postCardAction(this, {
            action: 'router',
            abilityName: 'EntryAbility',
            params: {
              targetTag: '111'
            }
          })
        })


        Column() {
          Image($r('app.media.img2'))
            .width('100%')
            .aspectRatio(1)
          Text(this.title)
            .fontColor(Color.Yellow)
            .fontSize('17fp')
            .margin('10vp')
            .fontWeight(FontWeight.Medium)
          Text(this.detail)
            .maxLines(2)
            .fontSize('13fp')
            .fontColor(Color.Gray)

        }.height('100%')
        .layoutWeight(1)
        .onClick(() => {
          postCardAction(this, {
            action: 'message',
            abilityName: 'EntryAbility',
            params: {
              targetTag: '222'
            }
          })
        })

        Column() {
          Image($r('app.media.img3'))
            .width('100%')
            .aspectRatio(1)
          Text(this.title)
            .fontColor(Color.Green)
            .fontSize('17fp')
            .margin('10vp')
            .fontWeight(FontWeight.Medium)
          Text(this.detail)
            .maxLines(2)
            .fontSize('13fp')
            .fontColor(Color.Gray)

        }.height('100%')
        .layoutWeight(1)
        .onClick(() => {
          postCardAction(this, {
            action: 'call',
            abilityName: 'EntryAbility',
            params: {
              method:'functionDynamicByCall',
              targetTag: '333'
            }
          })
        })
      }
    }

  }
}