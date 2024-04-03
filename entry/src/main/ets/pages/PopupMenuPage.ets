import { CommonButton } from './component/MyComponent'

@Entry
@Component
struct PopupMenuPage {
  @State isShowPopup: boolean = false
  @State isShowPopupCustom: boolean = false

  build() {
    Column() {
      CommonButton({ text: '普通气泡' })
        .onClick(() => {
          this.isShowPopup = !this.isShowPopup
        })
        .bindPopup(this.isShowPopup, {
          message: '这是popup',
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.isShowPopup = false
            }
          }
        })
      //带按钮的popup
      CommonButton({ text: '带按钮气泡' })
        .onClick(() => {
          this.isShowPopup = !this.isShowPopup
        })
        .bindPopup(this.isShowPopup, {
          message: '这是popup',
          primaryButton: {
            value: '确定',
            action: () => {
              this.isShowPopup = false
            }
          },
          secondaryButton: {
            value: '取消',
            action: () => {
              this.isShowPopup = false
            }
          },
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.isShowPopup = false
            }
          }
        })
      //自定义气泡
      CommonButton({ text: '自定义气泡' })
        .onClick(() => {
          this.isShowPopupCustom = !this.isShowPopupCustom
        })
        .bindPopup(this.isShowPopupCustom, {
          builder: this.popupBuilder,
          placement: Placement.Top,
          popupColor: Color.Pink,
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.isShowPopupCustom = false
            }
          }
        })


    }.width('100%')
    .height('100%')
  }

  @Builder popupBuilder() {
    Row({ space: 2 }) {
      Image($r('app.media.ic_delete')).width(30).height(30).margin({ left: 15 })
      Text('这是什么啊？').fontColor(Color.Red).margin({ right: 15 })
    }
    .alignItems(VerticalAlign.Center)
    .height(40)
    .padding(5)
  }
}