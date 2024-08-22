import { CommonTitle } from '../component/MyComponent';
import map from '@hms.core.map.map';


@Entry
@Component
struct StatePropLinkPage {
  private scroller: Scroller = new Scroller()
  /**
   * 1.私有的，只能在声明的组件内使用，声明时需要指定类型和初始值；
   * 2.@State与@Prop单向同步，与@Link和@ObjectLink双向同步；
   * 3.@State修饰变量的生命周期与所属组件的生命周期相同；
   * 4.
   */
  @State @Watch('testCountChange') testCount: number = 0

  testCountChange(propName: string) {
    console.debug('===Parent：' + this.testCount)
  }

  build() {
    Scroll(this.scroller) {

        Column({ space: 10 }) {
          Text(`Parent：${this.testCount}`).fontSize(18).fontColor(Color.Red)
          Button('Parent点击').onClick(() => {
            this.testCount++
          })
          SonProp({ testCount: this.testCount })
          SonLink({ testCount: this.testCount })
        }.width('100%')

    }.width('100%')
  }
}

@Component
struct SonLink {
  @Link @Watch('testCountChange') testCount: number

  testCountChange(propName: string) {
    console.debug('===SonLink：' + this.testCount)
  }

  build() {
    Column({ space: 8 }) {
      Text(`SonLink：${this.testCount}`).fontSize(16).fontColor(Color.Blue)
      Button('SonLink点击').onClick(() => {
        this.testCount++
      })
      Row() {
        GrandSonLink1({ testCount: this.testCount })
        GrandSonLink2({ testCount: this.testCount })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ left: 10 })
    }
  }
}

@Component
struct SonProp {
  @Prop @Watch('testCountChange') testCount: number

  testCountChange(propName: string) {
    console.debug('===SonProp：' + this.testCount)
  }

  build() {
    Column({ space: 8 }) {
      Text(`SonProp：${this.testCount}`).fontSize(16).fontColor(Color.Blue)
      Button('SonProp点击').onClick(() => {
        this.testCount++
      })
    }
  }
}

@Component
struct GrandSonLink1 {
  @Link @Watch('testCountChange') testCount: number

  testCountChange(propName: string) {
    console.debug('===GrandSonLink1：' + this.testCount)
  }

  build() {
    Column({ space: 8 }) {
      Text(`GrandSonLink1：${this.testCount}`).fontSize(14).fontColor(Color.Green)
      Button('GrandSonLink1点击').onClick(() => {
        this.testCount++
      })
    }
  }
}

@Component
struct GrandSonLink2 {
  @Link @Watch('testCountChange') testCount: number

  testCountChange(propName: string) {
    console.debug('===GrandSonLink2：' + this.testCount)
  }

  build() {
    Column({ space: 8 }) {
      Text(`GrandSonLink2：${this.testCount}`).fontSize(14).fontColor(Color.Green)
      Button('GrandSonLink2点击').onClick(() => {
        this.testCount++
      })
    }
  }
}
