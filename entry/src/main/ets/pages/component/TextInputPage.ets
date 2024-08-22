import { CommonTitle } from './MyComponent'
import { promptAction } from '@kit.ArkUI'
import { CustomToggle } from '../../widget/CustomToggle'

@Entry
@Component
struct TextInputPage {
  private scroller: Scroller = new Scroller()
  @State textAreaInputContent: string = ''
  textInputController: TextInputController = new TextInputController()
  @State inputContent: string = ''
  @State isShowUnderLine: boolean = false
  enterKetTypeArr: string[] = ['EnterKeyType.Go', 'EnterKeyType.Search', 'EnterKeyType.Send', 'EnterKeyType.Done'
    , 'EnterKeyType.Next', 'EnterKeyType.PREVIOUS', 'EnterKeyType.NEW_LINE']
  @State enterKeyType: EnterKeyType = EnterKeyType.Go
  inputTypeArr: string[] =
    ['Normal', 'Number', 'PhoneNumber', 'Email', 'Password', 'NUMBER_PASSWORD', 'USER_NAME', 'NEW_PASSWORD',
      'NUMBER_DECIMAL']
  inputType: InputType = InputType.Normal

  build() {
    Scroll(this.scroller) {
      Column({ space: 10 }) {
        CommonTitle({ title: '输入框' })
        Row() {
          TextInput({ placeholder: '请输入内容', text: $$this.inputContent, controller: this.textInputController })
            .fontSize(16)
            .fontColor(Color.Black)
            .fontStyle(FontStyle.Normal)
            .fontWeight(FontWeight.Normal)
            .textAlign(TextAlign.Start)//设置文本对齐方式
            .width('100%')
            .borderRadius(15)
            .backgroundColor(Color.Orange)
            .placeholderColor(Color.Gray)//设置展位文本颜色
            .placeholderFont({
              //设置占位文本样式
              size: 16,
              weight: FontWeight.Normal,
              style: FontStyle.Italic
            })
            .type(this.inputType)//输入类型
            .contentType(ContentType.PHONE_NUMBER)//设置自动填充类型
            .showUnderline(this.isShowUnderLine)//是否显示下划线
            .underlineColor({normal:Color.Orange,typing:Color.Green,error:Color.Red,disable:Color.Gray})//下划线颜色
            .enterKeyType(this.enterKeyType)//设置输入法回车键类型
            .caretColor(Color.Green)//设置光标颜色
              // .caretStyle({//设置光标风格
              //    width:3,
              //   color:Color.Green
              // })
              // .caretPosition(0)//设置光标位置
              // .inputFilter()
            .copyOption(CopyOptions.InApp)//设置是否可复制及粘贴范围
            .showPasswordIcon(false)//设置inputType为密码时是否显示末尾图标
            .passwordIcon({
              //设置密码输入类型末尾图标
              onIconSrc: $r('app.media.tab_home_t'),
              offIconSrc: $r('app.media.tab_home_f')
            })
            .style(TextInputStyle.Inline|TextContentStyle.INLINE)//设置输入框为默认风格或内联输入风格，内联输入风格只支持InputType.Normal类型
            .barState(BarState.Auto)//设置内联输入风格滚动条样式
            .maxLines(10)//设置内联输入风格最大输入行数 默认 3
            .selectedBackgroundColor(Color.Red)//设置文本选中的底板颜色
            .showUnit(this.itemEnd())//设置控件作为文本框单位。需搭配showUnderline使用，当showUnderline为true时生效
            .showError('输入有误')//当参数类型为ResourceStr并且输入内容不符合定义规范时，提示错误文本，当提示错误单行文本超长时，末尾以省略号显示。当参数类型为undefined时，不显示错误状态
            .enableKeyboardOnFocus(true)//设置TextInput通过点击以外的方式获焦时，是否绑定输入法。
            .selectionMenuHidden(false)//设置长按、双击输入框或者右键输入框时，是否"不弹出"文本选择菜单。
            // .customKeyboard(this.CustomKeyboardBuilder())//设置自定义键盘
            .enableAutoFill(true)//设置是否启用自动填充
              // .passwordRules('')//定义生成密码的规则。在触发自动填充时，所设置的密码规则会透传给密码保险箱，用于新密码的生成。
            .selectAll(false)//设置初始状态，是否全选文本
            .cancelButton({
              //设置左侧清除按钮样式，不支持内联模式
              style: CancelButtonStyle.INPUT,
              icon: {
                size: 20,
                src: $r('app.media.ic_delete')
              }
            })
            .maxLength(10)//设置文本最大输入字符数
            .showCounter(true, {
              //显示字数超出阈值，配合 maxLength使用
              //当输入字符数大于最大字符数乘百分比值时，显示字符计数器。如果用户设置计数器时不设置InputCounterOptions，
              // 那么当前输入字符数超过最大字符数时，边框和计数器下标将变为红色。用户同时设置参数value为true和InputCounterOptions，
              // 当thresholdPercentage数值在有效区间内，且输入字符数超过最大字符数时，边框和计数器下标将变为红色，框体抖动。
              // highlightBorder设置为false，则不显示红色边框，计数器默认显示红色，框体抖动。
              thresholdPercentage: 50,
              highlightBorder: true
            })
            .lineHeight(30)//设置行高
            .letterSpacing(5)//文本间距
            .decoration({
              //文本装饰线类型
              type: TextDecorationType.LineThrough,
              color: Color.Yellow,
              style: TextDecorationStyle.DOTTED
            })
            .wordBreak(WordBreak.NORMAL)//设置文本断行规则
            // .lineBreakStrategy(LineBreakStrategy.GREEDY)//设置折行策略，在WordBreak不为BREAK_ALL时生效
            .textOverflow(TextOverflow.Ellipsis)//设置文本超长的显示方式
            .textIndent(10)//设置首行文本缩进
            .minFontSize(12)//设置最小显示字号
            .maxFontSize(20)//设置最大显示字号
            .heightAdaptivePolicy(TextHeightAdaptivePolicy.MAX_LINES_FIRST)//组件设置为内联输入风格时，设置文本自适应高度的方式。
            .onChange((value: string) => {

            })
            .onEditChange((isEditing: boolean) => {
              //输入状态改变
            })
            .onSubmit((keyType: EnterKeyType, event: SubmitEvent) => {
              //点击键盘回车健回调
            })
            .onCopy((value: string) => {
              //复制回调
            })
            .onCut((value: string) => {
              //剪切回调
            })
            .onPaste((value: string, event: PasteEvent) => {
              //粘贴回调
            })
            .onTextSelectionChange((selectStart: number, selectEnd: number) => {
              //文本选择位置发生变化触发 默认从0开始
            })
            .onContentScroll((totalOffsetX: number, totalOffsetY: number) => {
              //内容滚动的回调
            })
            .onSecurityStateChange((isShow: boolean) => {
              //密码显隐状态切换回调
            })

        }.margin({ left: 16, right: 16 })

        Row() {
          CustomToggle({ text: '下划线', isOpen: this.isShowUnderLine })
        }

        Row({ space: 10 }) {
          Button('输入类型类型').onClick(() => {
            this.selectInputType()
          })
          Button('输入法回车键类型').onClick(() => {
            this.selectEnterKeyType()
          })
          //TextInputController api
          //设置光标位置
          // this.textInputController.caretPosition(this.inputContent.length)
          //退出编辑状态
          // this.textInputController.stopEditing()
          //设置文本选择区域并高亮显示
          Button('文本选中').onClick(() => {
            this.textInputController.setTextSelection(0, this.inputContent.length)
          })
        }.width('100%')

        CommonTitle({ title: '搜索组件-Search' })
        Search({ placeholder: '请输入搜索的内容' })
          .searchButton('搜索')
          .placeholderColor(Color.Gray)
          .placeholderFont({ style: FontStyle.Normal, size: 14, weight: 500 })
          .textAlign(TextAlign.Center)
          .textFont({ size: 14, style: FontStyle.Italic, weight: 500 })
          .backgroundColor('#f5f5f5')
          .width('90%')
          .onSubmit((content: string) => {
            promptAction.showToast({ message: content })
          })
          .copyOption(CopyOptions.InApp)
          .onChange((content: string) => {

          })
          .onCopy((content: string) => {

          })
          .onCut((content: string) => {

          })
          .onPaste((content: string) => {

          })

        CommonTitle({ title: 'TextArea' })
        TextArea({ placeholder: '请输入内容', text: this.textAreaInputContent })
          .width('60%')
          .constraintSize({
            minHeight: 60,
            maxHeight: 200
          })
          .type(TextAreaType.NUMBER)//输入内容类型
          .onChange((value: string) => {
            this.textAreaInputContent = value
          })//内容样式
          .fontSize(15)
          .fontColor(Color.Green)
          .fontStyle(FontStyle.Italic)
          .fontWeight(FontWeight.Bold)//placeHolder样式
          .placeholderColor(Color.Gray)
          .placeholderFont({
            size: 15, style: FontStyle.Normal, weight: FontWeight.Normal
          })//文本方向
          .textAlign(TextAlign.Start)
          .caretColor(Color.Yellow)//光标样式
            // .caretStyle({ width: 5, color: Color.Orange })
          .copyOption(CopyOptions.LocalDevice)//复制配置
          .onCopy((value: string) => { //复制回调
            promptAction.showToast({ message: value })
          })
          .style(TextContentStyle.DEFAULT)
          .maxLines(5)//最大行数
          .maxLength(100)//最大输入字符数
          .showCounter(true, {
            thresholdPercentage: 20, //thresholdPercentage是可输入字符数占最大字符限制的百分比值。大于百分比时显示
            highlightBorder: true
          })
          .selectionMenuHidden(false)//长按是否隐藏选择复制弹窗
          .enableAutoFill(true)//是否开启自动弹冲
          .contentType(ContentType.PHONE_NUMBER)//自动填充内容类型
          .enterKeyType(EnterKeyType.Send)//设置输入法回车键类型
          .decoration({
            //设置文本装饰线类型样式及其颜色。
            type: TextDecorationType.Underline,
            color: Color.Red,
            style: TextDecorationStyle.DOTTED
          })
          .wordBreak(WordBreak.BREAK_WORD)

      }.width('100%')
    }
    .width('100%')
  }

  //自定义键盘
  // 自定义键盘组件
  @Builder
  CustomKeyboardBuilder() {
    Column() {
      Button('x').onClick(() => {
        // 关闭自定义键盘
        this.textInputController.stopEditing()
      })
      Grid() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, '*', 0, '#'], (item: number | string) => {
          GridItem() {
            Button(item + "")
              .width(110).onClick(() => {
              this.inputContent += item
            })
          }
        })
      }.maxCount(3).columnsGap(10).rowsGap(10).padding(5)
    }.backgroundColor(Color.Gray)
  }

  //单位显示
  @Builder
  itemEnd() {
    Select([{ value: 'KB' },
      { value: 'MB' },
      { value: 'GB' },
      { value: 'TB', }])
      .height("48vp")
      .borderRadius(0)
      .selected(2)
      .align(Alignment.Center)
      .value('MB')
      .font({ size: 20, weight: 500 })
      .fontColor('#182431')
      .selectedOptionFont({ size: 20, weight: 400 })
      .optionFont({ size: 20, weight: 400 })
      .backgroundColor(Color.Transparent)
      .responseRegion({
        height: "40vp",
        width: "80%",
        x: '10%',
        y: '6vp'
      })
      .onSelect((index: number) => {
        console.info('Select:' + index)
      })
  }

  //选择输入法回车健类型
  selectEnterKeyType() {
    TextPickerDialog.show({
      range: this.enterKetTypeArr,
      canLoop: false,
      alignment: DialogAlignment.Bottom,
      onAccept: (result: TextPickerResult) => {
        switch (result.index) {
          case 0:
            this.enterKeyType = EnterKeyType.Go
            break
          case 1:
            this.enterKeyType = EnterKeyType.Search
            break
          case 2:
            this.enterKeyType = EnterKeyType.Send
            break
          case 3:
            this.enterKeyType = EnterKeyType.Done
            break
          case 4:
            this.enterKeyType = EnterKeyType.Next
            break
          case 5:
            this.enterKeyType = EnterKeyType.PREVIOUS
            break
          case 6:
            this.enterKeyType = EnterKeyType.NEW_LINE
            break
        }
      }
    })
  }

  /**
   * 'Normal','Number','PhoneNumber',
   * 'Email','Password','NUMBER_PASSWORD',
   * 'USER_NAME','NEW_PASSWORD','NUMBER_DECIMAL']
   */
  selectInputType() {
    TextPickerDialog.show({
      range: this.inputTypeArr,
      canLoop: false,
      alignment: DialogAlignment.Bottom,
      onAccept: (result: TextPickerResult) => {
        switch (result.index) {
          case 0:
            this.inputType = InputType.Normal
            break
          case 1:
            this.inputType = InputType.Number
            break
          case 2:
            this.inputType = InputType.PhoneNumber
            break
          case 3:
            this.inputType = InputType.Email
            break
          case 4:
            this.inputType = InputType.Password
            break
          case 5:
            this.inputType = InputType.NUMBER_PASSWORD
            break
          case 6:
            this.inputType = InputType.USER_NAME
            break
          case 7:
            this.inputType = InputType.NEW_PASSWORD
            break
          case 8:
            this.inputType = InputType.NUMBER_DECIMAL
            break
        }
      }
    })
  }
}