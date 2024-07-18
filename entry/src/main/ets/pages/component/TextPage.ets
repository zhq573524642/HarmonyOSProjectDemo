import { CommonTitle } from './MyComponent'

@Entry
@Component
struct TextPage {
  private scroller: Scroller = new Scroller()
  @State texWeight: FontWeight = FontWeight.Normal
  @State texWeightDesc: string = '切换FontWeight:Normal'
  @State textStyle: FontStyle = FontStyle.Normal
  @State textStyleDesc: string = '切换FontStyle:Normal'
  @State textDecorationType: TextDecorationType = TextDecorationType.None
  @State textDecorationTypeDesc: string = '切换TextDecorationType:None'
  @State textOverFlow: TextOverflow = TextOverflow.None
  @State textOverFlowDesc: string = 'TextOverflow.None'
  @State maxLines: number = 1
  @State letterSpacingNum: number = 0
  @State lineHeightNum: number = 30
  @State fontSizeNum: number = 13
  private textOverFlowMenuElement: MenuElement[] = [
    {
      value: 'TextOverflow.None',
      action: () => {
        this.textOverFlow = TextOverflow.None
        this.textOverFlowDesc = 'TextOverflow.None'
      }
    },
    {
      value: 'TextOverflow.Clip',
      action: () => {
        this.textOverFlow = TextOverflow.Clip
        this.textOverFlowDesc = 'TextOverflow.Clip'
      }
    },
    {
      value: 'TextOverflow.Ellipsis',
      action: () => {
        this.textOverFlow = TextOverflow.Ellipsis
        this.textOverFlowDesc = 'TextOverflow.Ellipsis'
      }
    },
    {
      value: 'TextOverflow.MARQUEE',
      action: () => {
        this.textOverFlow = TextOverflow.MARQUEE
        this.textOverFlowDesc = 'TextOverflow.MARQUEE'
      }
    }
  ]
  private textDecorationMenuElement: MenuElement[] = [
    {
      value: 'TextDecorationType.None',
      action: () => {
        this.textDecorationType = TextDecorationType.None
        this.textDecorationTypeDesc = '切换TextDecorationType:None'
      }
    },
    {
      value: 'TextDecorationType.Underline',
      action: () => {
        this.textDecorationType = TextDecorationType.Underline
        this.textDecorationTypeDesc = '切换TextDecorationType:Underline'
      }
    },
    {
      value: 'TextDecorationType.Overline',
      action: () => {
        this.textDecorationType = TextDecorationType.Overline
        this.textDecorationTypeDesc = '切换TextDecorationType:Overline'
      }
    },
    {
      value: 'TextDecorationType.LineThrough',
      action: () => {
        this.textDecorationType = TextDecorationType.LineThrough
        this.textDecorationTypeDesc = '切换TextDecorationType:LineThrough'
      }
    }
  ]
  private fontStyleMenuElement: MenuElement[] = [
    {
      value: 'FontStyle.Normal',
      action: () => {
        this.textStyle = FontStyle.Normal
        this.textStyleDesc = '切换FontStyle:Normal'
      }
    },
    {
      value: 'FontStyle.Italic',
      action: () => {
        this.textStyle = FontStyle.Italic
        this.textStyleDesc = '切换FontStyle:Italic'
      }
    }
  ]
  private fontWeightMenuElement: MenuElement[] = [
    {
      value: 'FontWeight.Normal',
      action: () => {
        this.texWeight = FontWeight.Normal
        this.texWeightDesc = '切换FontWeight:Normal'
      }
    },
    {
      value: 'FontWeight.Lighter',
      action: () => {
        this.texWeight = FontWeight.Lighter
        this.texWeightDesc = '切换FontWeight:Lighter'

      }
    },
    {
      value: 'FontWeight.Regular',
      action: () => {
        this.texWeight = FontWeight.Regular
        this.texWeightDesc = '切换FontWeight:Regular'
      }
    },
    {
      value: 'FontWeight.Medium',
      action: () => {
        this.texWeight = FontWeight.Medium
        this.texWeightDesc = '切换FontWeight:Medium'
      }
    },
    {
      value: 'FontWeight.Bold',
      action: () => {
        this.texWeight = FontWeight.Bold
        this.texWeightDesc = '切换FontWeight:Bold'
      }
    },
    {
      value: 'FontWeight.Bolder',
      action: () => {
        this.texWeight = FontWeight.Bolder
        this.texWeightDesc = '切换FontWeight:Bolder'
      }
    }
  ]

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '文本-Text' })
        Text('这是一个测试文本')
          .fontColor(Color.Blue)
          .fontSize(20)
          .fontWeight(this.texWeight)
          .fontStyle(this.textStyle)
          .minFontSize(15)
          .maxFontSize(30)
          .margin(10)
          .decoration({ type: this.textDecorationType, color: Color.Red })
        Text() {
          Span('文本子组件-Span')
            .fontColor(Color.Blue)
            .fontSize(20)
            .margin(10)
            .fontStyle(this.textStyle)
            .fontWeight(this.texWeight)
            .decoration({ type: this.textDecorationType, color: Color.Red })
        }

        MyButton({
          text: this.texWeightDesc,
          elementArr: this.fontWeightMenuElement
        })
        MyButton({
          text: this.textStyleDesc,
          elementArr: this.fontStyleMenuElement
        })
        MyButton({
          text: this.textDecorationTypeDesc,
          elementArr: this.textDecorationMenuElement
        })


        Text('These are all uppercase')
          .textCase(TextCase.UpperCase)
          .fontColor(Color.Black)
          .fontSize(20)
          .fontWeight(FontWeight.Regular)
          .fontStyle(FontStyle.Normal)
          .minFontSize(15)
          .maxFontSize(30)
          .margin(10)
        Text('可以复制：这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本' +
          '这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本' +
          '这是长文本这是长文本这是长文本这是长文本这是长文本这是长文本')
          .textOverflow({ overflow: this.textOverFlow })
          .maxLines(this.maxLines)
          .lineHeight(this.lineHeightNum)
          .letterSpacing(this.letterSpacingNum)
          .fontColor(Color.Black)
          .fontSize(this.fontSizeNum)
          .fontWeight(FontWeight.Regular)
          .fontStyle(FontStyle.Normal)
          .margin(10)
          .copyOption(CopyOptions.InApp)
          .borderWidth(1)
          .borderColor(Color.Green)
          .padding(10)
        MyButton({ text: this.textOverFlowDesc, elementArr: this.textOverFlowMenuElement })
        Counter() {
          Text(`maxLines:${this.maxLines}`).fontColor(Color.Red).fontSize(20)
        }
        .width("70%")
        .margin(10)
        .onInc(() => {
          this.maxLines++
          if (this.maxLines > 5) {
            this.maxLines = 5
          }
        })
        .onDec(() => {
          this.maxLines--
          if (this.maxLines < 1) {
            this.maxLines = 1
          }
        })

        MySlider({
          title: 'letterSpacing:',
          min: 0,
          max: 30,
          onValueCallback: (value: number) => {
            this.letterSpacingNum = value
          }
        })
        MySlider({
          title: 'lineHeight:',
          min: 30,
          max: 60,
          onValueCallback: (value: number) => {
            this.lineHeightNum = value
          }
        })
        MySlider({
          title: 'fontSize:',
          min: 12,
          max: 30,
          onValueCallback: (value: number) => {
            this.fontSizeNum = value
          }
        })
        // CommonTitle({ title: '富文本-RichText' })
        // RichText(this.richTextContent)
        //   .onStart(() => {
        //     console.debug('===richText-onStart')
        //   })
        //   .onComplete(() => {
        //     console.debug('===richText=-onComplete')
        //   })
      }.width('100%')
    }.width('100%')
  }
}

@Component
struct MyButton {
  @Link text: string
  elementArr: MenuElement[] = []

  build() {
    Row() {
      Button(this.text, { type: ButtonType.Capsule })
        .width('90%')
        .fontColor(Color.Black)
        .backgroundColor(Color.Pink)
        .bindMenu(this.elementArr)
        .margin(10)
    }
  }
}

@Component
struct MySlider {
  title: string = ''
  onValueCallback?: (value: number) => void
  min: number = 0
  max: number = 100

  build() {
    Row() {
      Text(this.title).fontSize(13).fontColor(Color.Black)
        .margin({ left: 15 })
      Slider({ min: this.min, max: this.max })
        .stepSize(2)
        .showSteps(true)
        .showTips(true)
        .layoutWeight(1)
        .height(20)
        .trackColor(Color.Yellow)
        .blockColor(Color.Red)
        .margin({ left: 10, right: 15 })
        .onChange((value: number, mode: SliderChangeMode) => {
          if (this.onValueCallback) {
            this.onValueCallback(value)
          }
        })
    }.justifyContent(FlexAlign.Center)
    .width('100%')
  }
}