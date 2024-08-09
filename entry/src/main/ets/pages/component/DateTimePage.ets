import { CommonButton, CommonTitle } from './MyComponent'
import { promptAction } from '@kit.ArkUI'
import { DateUtil } from '../../utils/DateUtil'

@Entry
@Component
struct DateTimePage {
  private scroller: Scroller = new Scroller()
  private textClockController: TextClockController = new TextClockController()
  @State isTextTimerCountDown: boolean = false
  private textTimerController: TextTimerController = new TextTimerController()
  @State currentDate: Date = new Date()
  @State isLunar: boolean = false
  @State isTimeShow: boolean = false
  @State useMilitaryTime: boolean = true

  build() {
    Scroll(this.scroller) {
      Column({ space: 8 }) {
        CommonTitle({title:'Date Api'})
        Text(`toString：${this.currentDate.toString()}`)
        Text(`toDateString：${this.currentDate.toDateString()}`)
        Text(`toTimeString：${this.currentDate.toTimeString()}`)
        Text(`toLocaleString：${this.currentDate.toLocaleString()}`)
        Text(`toLocaleDateString：${this.currentDate.toLocaleDateString()}`)
        Text(`toLocaleTimeString：${this.currentDate.toLocaleTimeString()}`)
        Text(`toUTCString：${this.currentDate.toUTCString()}`)
        Text(`toISOString：${this.currentDate.toISOString()}`)
        Text(`getDate：${this.currentDate.getDate()}`)
        Text(`getUTCDate：${this.currentDate.getUTCDate()}`)
        Text(`getFullYear：${this.currentDate.getFullYear()}`)
        Text(`getUTCFullYear：${this.currentDate.getUTCFullYear()}`)
        Text(`getMonth：${this.currentDate.getMonth()}`)
        Text(`getUTCMonth：${this.currentDate.getUTCMonth()}`)
        Text(`getDay：${this.currentDate.getDay()}`)
        Text(`getUTCDay：${this.currentDate.getUTCDay()}`)
        Text(`getHours：${this.currentDate.getHours()}`)
        Text(`getUTCHours：${this.currentDate.getUTCHours()}`)
        Text(`getMinutes：${this.currentDate.getMinutes()}`)
        Text(`getUTCMinutes：${this.currentDate.getUTCMinutes()}`)
        Text(`getSeconds：${this.currentDate.getSeconds()}`)
        Text(`getUTCSeconds：${this.currentDate.getUTCSeconds()}`)
        Text(`getMilliseconds：${this.currentDate.getMilliseconds()}`)
        Text(`getUTCMilliseconds：${this.currentDate.getUTCMilliseconds()}`)
        Text(`getTimezoneOffset：${this.currentDate.getTimezoneOffset()}`)
        Text(`获取时间yyyy-MM-dd HH:mm:ss：${DateUtil.getTodayStr('yyyy-MM-dd HH:mm:ss')}`)
        Text(`获取时间yyyy-MM-dd：${DateUtil.getTodayStr('yyyy-MM-dd')}`)
        Text(`获取时间yyyy-MM-dd HH:mm：${DateUtil.getTodayStr('yyyy-MM-dd HH:mm')}`)
        Text(`获取时间yyyy年MM月dd日 HH:mm：${DateUtil.getTodayStr('yyyy年MM月dd日 HH:mm')}`)
        CommonTitle({ title: 'TextClock' })
        TextClock({ timeZoneOffset: -8, controller: this.textClockController })
          .format('yyyy/MM/dd hh:mm:ss')
          .fontColor(Color.Pink)
          .fontSize(30)
          .fontWeight(FontWeight.Bolder)
          .onDateChange((value: number) => {

          })
        Row() {
          Button('Start-time').onClick(() => {
            this.textClockController.start()
          })
          Button('Stop-time').onClick(() => {
            this.textClockController.stop()
          })
        }
        .width('100%').justifyContent(FlexAlign.SpaceEvenly)

        CommonTitle({ title: 'TextTimer' })
        TextTimer({ isCountDown: this.isTextTimerCountDown, count: 60000, controller: this.textTimerController })
          .fontColor(Color.Orange)
          .fontSize(30)
          .fontWeight(FontWeight.Bolder)
          .onTimer((utc: number, elapsedTime: number) => {
            console.debug('===TextTimer：' + utc + '--elapsedTime:' + elapsedTime)
          })
        Row() {
          Button('isCountDown').onClick(() => {
            this.isTextTimerCountDown = !this.isTextTimerCountDown
          })
          Button('start').onClick(() => {
            this.textTimerController.start()
          })
          Button('pause').onClick(() => {
            this.textTimerController.pause()
          })
          Button('reset').onClick(() => {
            this.textTimerController.reset()
          })
        }.justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')

        CommonTitle({ title: 'CalendarPicker' })
        CalendarPicker({ hintRadius: 18, selected: this.currentDate })
          .edgeAlign(CalendarAlign.CENTER)
          .textStyle({
            color: Color.Green,
            font: {
              size: 18,
              weight: FontWeight.Regular
            }
          })
          .onChange((value: Date) => {
            console.debug('===CalendarPicker：' + value.toDateString())
          })
        CommonButton({ text: 'CalendarPickerDialog' })
          .onClick(() => {
            this.CalendarPickerDialogShow()
          })
        CommonButton({ text: 'DatePickerDialog' })
          .onClick(() => {
            this.DatePickerDialogShow()
          })
        Row({ space: 5 }) {
          Text('是否显示农历')
          Toggle({ type: ToggleType.Switch, isOn: false })
            .onChange((isOn: Boolean) => {
              // this.toggleSwitch = isOn ? '开' : '关'
              this.isLunar = isOn.valueOf()
            })
            .switchPointColor(Color.Red)
            .selectedColor(Color.Yellow)
          Text('是否展示时间项')
          Toggle({ type: ToggleType.Switch, isOn: false })
            .onChange((isOn: Boolean) => {
              // this.toggleSwitch = isOn ? '开' : '关'
              this.isTimeShow = isOn.valueOf()
            })
            .switchPointColor(Color.Red)
            .selectedColor(Color.Yellow)
        }

        Row() {
          Text('是否为24小时制')
          Toggle({ type: ToggleType.Switch, isOn: true })
            .onChange((isOn: Boolean) => {
              // this.toggleSwitch = isOn ? '开' : '关'
              this.useMilitaryTime = isOn.valueOf()
            })
            .switchPointColor(Color.Red)
            .selectedColor(Color.Yellow)
        }

        CommonButton({ text: 'TimePickerDialog' })
          .onClick(() => {
            this.TimePickerDialogShow()
          })
      }.width('100%')
    }.width('100%')
  }

  CalendarPickerDialogShow() {
    CalendarPickerDialog.show({
      selected: this.currentDate,
      backgroundColor: Color.Pink, //面板背景色
      backgroundBlurStyle: BlurStyle.COMPONENT_ULTRA_THIN, //弹窗背板模糊材质
      acceptButtonStyle: {
        //确定按钮样式
        fontSize: 15,
        borderRadius: 10,
        backgroundColor: Color.Yellow,
        fontColor: Color.Red,
        fontStyle: FontStyle.Normal,
        fontWeight: FontWeight.Normal,
        style: ButtonStyleMode.NORMAL,
        type: ButtonType.Normal
      },
      cancelButtonStyle: {
        //取消按钮样式
        fontSize: 15,
        borderRadius: 10,
        backgroundColor: Color.Gray,
        fontColor: Color.Black,
        fontStyle: FontStyle.Normal,
        fontWeight: FontWeight.Normal,
        style: ButtonStyleMode.NORMAL,
        type: ButtonType.Normal
      },
      shadow: ShadowStyle.OUTER_FLOATING_MD,
      onChange: (value: Date) => { //选择弹窗中切换回调

      },
      onAccept: (value: Date) => { //确认按钮
      },
      onCancel: () => { //取消按钮

      }
    })

  }

  DatePickerDialogShow() {
    DatePickerDialog.show({
      start: new Date(2000, 1, 1),
      end: new Date(2050, 12, 31),
      selected: this.currentDate,
      lunar: this.isLunar, //是否显示农历
      showTime: this.isTimeShow, //是否展示时间项
      useMilitaryTime: this.useMilitaryTime, //是否为24小时制
      lunarSwitch: true, //是否展示切换农历的开关
      alignment: DialogAlignment.Bottom, //dialog展示的位置
      disappearTextStyle: {
        //设置所有选项中最上和最下两个选项的文本样式
        color: Color.Red,
        font: {
          size: 12,
          weight: FontWeight.Bold
        }
      },
      textStyle: {
        //设置所有选项中除了最上、最下及选中项以外的文本样式。
        color: Color.Green,
        font: {
          size: 14,
          weight: FontWeight.Regular
        }
      },
      selectedTextStyle: {
        //设置选中项文本的样式
        color: Color.Yellow,
        font: {
          size: 18,
          weight: FontWeight.Bolder
        }
      },
      backgroundColor: Color.Pink, //面板背景色
      backgroundBlurStyle: BlurStyle.COMPONENT_ULTRA_THIN, //弹窗背板模糊材质
      acceptButtonStyle: {
        //确定按钮样式
        fontSize: 15,
        borderRadius: 10,
        backgroundColor: Color.Yellow,
        fontColor: Color.Red,
        fontStyle: FontStyle.Normal,
        fontWeight: FontWeight.Normal,
        style: ButtonStyleMode.NORMAL,
        type: ButtonType.Normal
      },
      cancelButtonStyle: {
        //取消按钮样式
        fontSize: 15,
        borderRadius: 10,
        backgroundColor: Color.Gray,
        fontColor: Color.Black,
        fontStyle: FontStyle.Normal,
        fontWeight: FontWeight.Normal,
        style: ButtonStyleMode.NORMAL,
        type: ButtonType.Normal
      },
      shadow: ShadowStyle.OUTER_FLOATING_MD,
      onDateAccept: (value: Date) => {

      },
      onCancel: () => {

      },
      onDateChange: (value: Date) => {
        this.currentDate = value
      }
    })
  }

  TimePickerDialogShow() {
    TimePickerDialog.show({
      selected: new Date('2025-7-19T08:30:00'),
      useMilitaryTime: this.useMilitaryTime,
      alignment: DialogAlignment.Bottom, //dialog展示的位置
      disappearTextStyle: {
        //设置所有选项中最上和最下两个选项的文本样式
        color: Color.Red,
        font: {
          size: 12,
          weight: FontWeight.Bold
        }
      },
      textStyle: {
        //设置所有选项中除了最上、最下及选中项以外的文本样式。
        color: Color.Green,
        font: {
          size: 14,
          weight: FontWeight.Regular
        }
      },
      selectedTextStyle: {
        //设置选中项文本的样式
        color: Color.Yellow,
        font: {
          size: 18,
          weight: FontWeight.Bolder
        }
      },
      backgroundColor: Color.Pink, //面板背景色
      backgroundBlurStyle: BlurStyle.COMPONENT_ULTRA_THIN, //弹窗背板模糊材质
      acceptButtonStyle: {
        //确定按钮样式
        fontSize: 15,
        borderRadius: 10,
        backgroundColor: Color.Yellow,
        fontColor: Color.Red,
        fontStyle: FontStyle.Normal,
        fontWeight: FontWeight.Normal,
        style: ButtonStyleMode.NORMAL,
        type: ButtonType.Normal
      },
      cancelButtonStyle: {
        //取消按钮样式
        fontSize: 15,
        borderRadius: 10,
        backgroundColor: Color.Gray,
        fontColor: Color.Black,
        fontStyle: FontStyle.Normal,
        fontWeight: FontWeight.Normal,
        style: ButtonStyleMode.NORMAL,
        type: ButtonType.Normal
      },
      shadow: ShadowStyle.OUTER_FLOATING_MD,
      onAccept: (value: TimePickerResult) => {

      },
      onCancel: () => {

      },
      onChange: (value: TimePickerResult) => {

      }
    })
  }
}