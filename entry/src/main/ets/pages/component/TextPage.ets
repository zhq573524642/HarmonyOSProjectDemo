import { CommonTitle } from './MyComponent'
import { LengthMetrics } from '@kit.ArkUI'

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
  @State counterIndex: number = 0
  @State marqueeStart: boolean = false
  @State marqueeFromStart: boolean = false
  private richTextContent: string =
    '<h1 style="color:blue;text-align:center;">这是h1标题</h1>' +
      '<h2 style="color:red;text-align:center;">这是h2标题</h2>' +
      '<h3><i>这是h3斜体标题</i></h3>' +
      '<h4><i>这是h4斜体标题</i></h4>' +
      '<h5><i>这是h5斜体标题</i></h5>' +
      '<h6><i>这是h6斜体标题</i></h6>' +
      '<p>这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊' +
      '这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊这是一个段落啊</p>'
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
  mutableStyleString: MutableStyledString = new MutableStyledString('今天真是个好日子啊！\n不是吗？？', [
    {
      //设置文本样式
      start: 0,
      length: 2,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({
        fontColor: Color.Red,
        fontSize: LengthMetrics.vp(18),
        fontWeight: FontWeight.Bold,
        fontStyle: FontStyle.Normal
      })
    },
    {
      //设置文本样式
      start: 2,
      length: 3,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({
        fontColor: Color.Green,
        fontSize: LengthMetrics.vp(22),
        fontWeight: FontWeight.Normal,
        fontStyle: FontStyle.Italic
      })
    },
    {
      //设置文本阴影
      start: 5,
      length: 3,
      styledKey: StyledStringKey.TEXT_SHADOW,
      styledValue: new TextShadowStyle({
        radius: 10,
        type: ShadowType.COLOR,
        color: Color.Orange,
        offsetX: 20,
        offsetY: 20
      })
    },
    {
      //设置文本装饰线
      start: 0,
      length: 2,
      styledKey: StyledStringKey.DECORATION,
      styledValue: new DecorationStyle({
        type: TextDecorationType.Underline,
        color: Color.Blue,
        style: TextDecorationStyle.DOUBLE
      })
    },
    {
      //设置基线偏移
      start: 2,
      length: 3,
      styledKey: StyledStringKey.BASELINE_OFFSET,
      styledValue: new BaselineOffsetStyle(LengthMetrics.px(20))
    },
    {
      //设置行高
      start: 10,
      length: 5,
      styledKey: StyledStringKey.LINE_HEIGHT,
      styledValue: new LineHeightStyle(LengthMetrics.vp(50))
    },
    {
      //设置字符间距
      start: 10,
      length: 5,
      styledKey: StyledStringKey.LETTER_SPACING,
      styledValue: new LetterSpacingStyle(LengthMetrics.vp(15))
    },
    {
      //设置段落样式 缩进/位置
      start: 10,
      length: 5,
      styledKey: StyledStringKey.PARAGRAPH_STYLE,
      styledValue: new ParagraphStyle({ textIndent: LengthMetrics.px(20) })
    }
  ])
  textController2: TextController = new TextController()
  textController1: TextController = new TextController()
  textStyle1: TextStyle = new TextStyle({ fontWeight: FontWeight.Bold })
  paragraphStyle1: ParagraphStyle = new ParagraphStyle({ textAlign: TextAlign.Center })
  lineHeightStyle1: LineHeightStyle = new LineHeightStyle(LengthMetrics.vp(20))
  mutableStyleString1: MutableStyledString =
    new MutableStyledString('您的豪华钻石已过期1天\n续费可继续享受会员专属权益', [
      {
        start: 0,
        length: 11,
        styledKey: StyledStringKey.FONT,
        styledValue: new TextStyle({
          fontColor: Color.Black,
          fontWeight: FontWeight.Bold,
          fontSize: LengthMetrics.vp(20)
        })
      },
      {
        start: 0,
        length: 11,
        styledKey: StyledStringKey.PARAGRAPH_STYLE,
        styledValue: this.paragraphStyle1
      },
      {
        start: 11,
        length: 14,
        styledKey: StyledStringKey.PARAGRAPH_STYLE,
        styledValue: this.paragraphStyle1
      },
      {
        start: 11,
        length: 14,
        styledKey: StyledStringKey.FONT,
        styledValue: new TextStyle({
          fontColor: Color.Gray,
          fontWeight: FontWeight.Normal,
          fontSize: LengthMetrics.vp(14)
        })
      },
    ])
  mutableStyleString2: MutableStyledString = new MutableStyledString('\n￥6.88￥18.88', [
    {
      start: 0,
      length: 4,
      styledKey: StyledStringKey.PARAGRAPH_STYLE,
      styledValue: this.paragraphStyle1
    },
    {
      start: 0,
      length: 4,
      styledKey: StyledStringKey.LINE_HEIGHT,
      styledValue: new LineHeightStyle(LengthMetrics.vp(60))
    },
    {
      start: 0,
      length: 6,
      styledKey: StyledStringKey.FONT,
      styledValue: this.textStyle1
    },
    {
      start: 2,
      length: 4,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontWeight: FontWeight.Bolder, fontSize: LengthMetrics.vp(40) })
    },
    {
      start: 6,
      length: 6,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontSize: LengthMetrics.vp(12), fontColor: Color.Gray })
    },
    {
      start: 6,
      length: 6,
      styledKey: StyledStringKey.DECORATION,
      styledValue: new DecorationStyle({ type: TextDecorationType.LineThrough, color: Color.Gray })
    },
  ])

  async onPageShow() {
    this.textController2.setStyledString(this.mutableStyleString)
  }

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
        CommonTitle({ title: '富文本-RichText' })
        RichText(this.richTextContent)
          .width('90%')
          .height(300)
          .onStart(() => {
            console.debug('===richText-onStart')
          })
          .onComplete(() => {
            console.debug('===richText=-onComplete')
          })

        CommonTitle({ title: 'Counter' })
        Counter() {
          Text(this.counterIndex + '').fontColor(Color.Red).fontSize(20)
        }.onInc(() => {
          this.counterIndex++
        })
        .onDec(() => {
          this.counterIndex--
        })

        CommonTitle({ title: 'Badge' })
        Badge({
          count: 10,
          maxCount: 99,
          position: BadgePosition.RightTop,
          style: {
            color: Color.White,
            fontSize: 10,
            badgeSize: 16,
            badgeColor: Color.Red
          }
        }) {
          Text('右上角的数字').fontSize(20).fontColor(Color.Black)
        }

        Badge({
          value: 'New',
          position: BadgePosition.Right,
          style: {
            color: Color.White,
            fontSize: 10,
            badgeSize: 16,
            badgeColor: Color.Red
          }
        }) {
          Text('右边的文本').fontSize(20).fontColor(Color.Black).margin({ right: 20 })
        }

        CommonTitle({ title: '跑马灯-Marquee' })
        Marquee({
          start: this.marqueeStart,
          step: 20,
          loop: -1,
          fromStart: this.marqueeFromStart,
          src: '一人我饮酒醉，醉把佳人成双对，两眼我独相随，只求他日能双归，娇女我轻抚琴，燕戏他紫竹林。十年戎马心孤单，隐退江湖归深山。'
        })
          .fontColor(Color.White)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .height(60)
          .backgroundColor(Color.Black)
          .margin({ bottom: 10 })
        Button('start-marquee')
          .onClick(() => {
            this.marqueeStart = true
            this.marqueeFromStart = !this.marqueeFromStart
          })
        CommonTitle({ title: 'StyledString/MutableStyledString' })

        Text(undefined, { controller: this.textController2 })
        Column() {
          Text(undefined, { controller: this.textController1 })
            .width(300)
            .onAppear(() => {
              this.mutableStyleString1.appendStyledString(this.mutableStyleString2)
              this.textController1.setStyledString(this.mutableStyleString1)
            })
        }.width('70%')
        .border({ radius: 5, color: Color.Orange, width: 1 })

        CommonTitle({ title: 'SymbolGlyph/SymbolSpan' })
        Row() {
          SymbolGlyph($r('sys.symbol.ohos_trash'))
            .fontSize(60)
            .fontColor([Color.Red, Color.Yellow, Color.Blue])
            .fontWeight(FontWeight.Bold)
            .effectStrategy(SymbolEffectStrategy.NONE)//设置SymbolGlyph组件动效策略。
            .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR) //设置SymbolGlyph组件渲染策略。单色、分层、多色

        }.width('100%')

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