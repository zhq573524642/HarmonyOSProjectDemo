import { CommonTitle } from './MyComponent'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct TogglePage {
  private scroller: Scroller = new Scroller()
  @State toggleSwitch: string = '开'
  @State toggleCheckbox: string = '开'
  @State toggleButton: string = '开'

  build() {
    Scroll() {
      Column() {
        CommonTitle({ title: '单选框-Radio' })
        Row() {
          Text('男')
            .fontSize(13)
          Radio({ value: 'man', group: 'group1', indicatorType: RadioIndicatorType.TICK })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：男' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
          Text('女')
            .fontSize(13)
            .margin({ left: 20 })
          Radio({ value: 'woman', group: 'group1', indicatorType: RadioIndicatorType.TICK })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：女' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
        }.alignItems(VerticalAlign.Center)

        Row() {
          Text('男')
            .fontSize(13)
          Radio({ value: 'man', group: 'group2', indicatorType: RadioIndicatorType.DOT })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：男' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
          Text('女')
            .fontSize(13)
            .margin({ left: 20 })
          Radio({ value: 'woman', group: 'group2', indicatorType: RadioIndicatorType.DOT })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：女' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
        }.alignItems(VerticalAlign.Center)

        Row() {
          Text('男')
            .fontSize(13)
          Radio({
            value: 'man',
            group: 'group3',
            indicatorType: RadioIndicatorType.CUSTOM,
            indicatorBuilder: this.customRadioStyle()
          })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：男' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
          Text('女')
            .fontSize(13)
            .margin({ left: 20 })
          Radio({
            value: 'woman',
            group: 'group3',
            indicatorType: RadioIndicatorType.CUSTOM,
            indicatorBuilder: this.customRadioStyle()
          })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：女' })
              }
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
        }.alignItems(VerticalAlign.Center)

        Row() {
          Text('男')
            .fontSize(13)
          Radio({ value: 'man', group: 'group4', indicatorType: RadioIndicatorType.TICK })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：男' })
              }
            })
            .radioStyle({
              checkedBackgroundColor: Color.Green,//开启状态底板颜色
              uncheckedBorderColor: Color.Yellow,//关闭状态描边颜色。
              indicatorColor: Color.Red//开启状态内部圆饼颜色
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
          Text('女')
            .fontSize(13)
            .margin({ left: 20 })
          Radio({ value: 'woman', group: 'group4', indicatorType: RadioIndicatorType.TICK })
            .onChange((isCheck: boolean) => {
              if (isCheck) {
                promptAction.showToast({ message: '选中：女' })
              }
            })
            .radioStyle({
              checkedBackgroundColor: Color.Green,
              uncheckedBorderColor: Color.Yellow,
              indicatorColor: Color.Red
            })
            .width(25)
            .height(25)
            .margin({ left: 10 })
        }.alignItems(VerticalAlign.Center)

        CommonTitle({ title: '多选框-CheckboxGroup和Checkbox' })

        Column() {
          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            CheckboxGroup({ group: 'checkbox_group' })
              .selectedColor(Color.Pink)
              .unselectedColor(Color.Pink)
              .checkboxShape(CheckBoxShape.ROUNDED_SQUARE)
              .onChange((event: CheckboxGroupResult) => {
                console.debug('===CheckboxGroup：' + event.name.toString())
              })
            Text('CheckboxGroup').fontColor(Color.Black).fontSize(13)
          }

          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: 'Item-1', group: 'checkbox_group' })
              .selectedColor(Color.Red)
              .unselectedColor(Color.Red)
              .onChange((isChecked: boolean) => {
                console.debug('===item1：' + isChecked)
              })
            Text('Item1').fontSize(13).fontColor(Color.Black)
          }.margin({ left: 36 })

          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: 'Item-2', group: 'checkbox_group' })
              .selectedColor(Color.Yellow)
              .unselectedColor(Color.Yellow)
              .onChange((isChecked: boolean) => {
                console.debug('===item2：' + isChecked)
              })
            Text('Item2').fontSize(13).fontColor(Color.Black)
          }.margin({ left: 36 })

          Flex({ alignContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
            Checkbox({ name: 'Item-3', group: 'checkbox_group' })
              .selectedColor(Color.Blue)
              .unselectedColor(Color.Blue)
              .onChange((isChecked: boolean) => {
                console.debug('===item3：' + isChecked)
              })
            Text('Item3').fontSize(13).fontColor(Color.Black)
          }.margin({ left: 36 })
        }.width('100%')
        .alignItems(HorizontalAlign.Center)

        CommonTitle({ title: '切换按钮-ToggleType.Switch' })
        Toggle({ type: ToggleType.Switch, isOn: true })
          .onChange((isOn: Boolean) => {
            // this.toggleSwitch = isOn ? '开' : '关'
          })
          .switchPointColor(Color.Red)
          .selectedColor(Color.Green)
        CommonTitle({ title: '切换按钮-ToggleType.Checkbox' })
        Toggle({ type: ToggleType.Checkbox, isOn: true })
          .onChange((isOn: Boolean) => {
            // this.toggleCheckbox = isOn ? '开' : '关'
          })
          .selectedColor(Color.Pink)
        CommonTitle({ title: '切换按钮-ToggleType.Button' })
        Toggle({ type: ToggleType.Button, isOn: true }) {
          Text(this.toggleButton)
            .fontSize(15)
            .fontColor(Color.Black)
        }
        .selectedColor(Color.Brown)
        .width(40)
        .height(30)
        .onChange((isOn: Boolean) => {
          this.toggleButton = isOn ? '开' : '关'
        })

      }.width('100%')
    }.width('100%')
  }

  @Builder
  customRadioStyle() {
    Image($r('app.media.img2')).width(20).height(20).borderRadius(15)
  }
}