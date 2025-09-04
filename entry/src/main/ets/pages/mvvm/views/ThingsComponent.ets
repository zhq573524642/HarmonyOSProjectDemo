import ThingsViewModel from "../viewmodel/ThingsViewModel"

@Component
export struct ThingsComponent {
  @Prop thingsViewModel: ThingsViewModel

  @Builder
  checkImage(iconRes: ResourceStr) {
    Image(iconRes)
      .width(25)
      .height(25)
      .onClick(() => {
        this.thingsViewModel.updateIsFinished()
      })
  }

  build() {
    Row({ space: 20 }) {
      if (this.thingsViewModel.isFinished) {
        this.checkImage($r('app.media.ic_collect_select'))
      } else {
        this.checkImage($r('app.media.ic_collect_unselect'))
      }

      Text(this.thingsViewModel.thingsName)
        .fontSize(18)
        .fontColor(this.thingsViewModel.isFinished ? Color.Grey : Color.Black)
        .decoration({
          type: this.thingsViewModel.isFinished ? TextDecorationType.LineThrough : TextDecorationType.None,
          color: Color.Red
        })
    }.width('90%')
    .padding({top:10,bottom:10})
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.thingsViewModel.updateIsFinished()
    })
  }
}