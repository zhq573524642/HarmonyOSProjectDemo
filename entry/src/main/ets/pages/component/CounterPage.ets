import { CounterComponent, CounterType, DateData } from '@ohos.arkui.advanced.Counter'

@Entry
@Component
struct CounterPage {
  @State counterIndex: number = 0
  @State year: number = 2024
  @State month: number = 8
  @State day: number = 22

  build() {
    Column({ space: 12 }) {
      Counter() {
        Text(this.counterIndex + '').fontColor(Color.Red).fontSize(20)
      }.onInc(() => {
        this.counterIndex++
      })
      .onDec(() => {
        this.counterIndex--
      })

      //列表型
      CounterComponent({
        options: {
          type: CounterType.LIST, //Counter类型
          numberOptions: {
            value: this.counterIndex,
            min: 0,
            max: 100,
            textWidth: 100,
            step: 1,
            onChange: (value: number) => {
              this.counterIndex = value
            },
            label: '计数',
            onFocusIncrease: () => {
              console.debug('===onFocusIncrease')
            },
            onFocusDecrease: () => {
              console.debug('===onFocusDecrease')
            },
            onBlurIncrease: () => {
              console.debug('===onBlurIncrease')
            },
            onBlurDecrease: () => {
              console.debug('===onBlurDecrease')
            },
            onHoverIncrease: (isHover: boolean) => {
              console.debug('===onHoverIncrease')
            },
            onHoverDecrease: (isHover: boolean) => {
              console.debug('===onHoverDecrease')
            }
          }
        }
      })
      //紧凑型
      CounterComponent({
        options: {
          type: CounterType.COMPACT, //Counter类型
          numberOptions: {
            value: this.counterIndex,
            min: 0,
            max: 100,
            textWidth: 100,
            step: 1,
            onChange: (value: number) => {
              this.counterIndex = value
            },
            label: '计数'
          }
        }
      })
      //普通数字内联型
      CounterComponent({
        options: {
          type: CounterType.INLINE, //Counter类型
          inlineOptions: {
            value: this.counterIndex,
            min: 0,
            max: 100,
            textWidth: 100,
            step: 1,
            onChange: (value: number) => {
              this.counterIndex = value
            }
          }
        }
      })
      //日期内联型
      CounterComponent({
        options: {
          type: CounterType.INLINE_DATE, //Counter类型
          dateOptions: {
            step: 1,
            year: this.year,
            month: this.month,
            day: this.day,
            onDateChange: (date: DateData) => {
              this.year = date.year
              this.month = date.month
              this.day = date.day
            }
          }
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}