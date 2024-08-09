import { CommonTitle } from './MyComponent'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct TextInputPage {
  private scroller: Scroller = new Scroller()
  @State textAreaInputContent: string = ''

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonTitle({ title: '输入框' })
        TextInput({ placeholder: '请输入账号' })
          .type(InputType.Number)
          .enterKeyType(EnterKeyType.Next)
          .backgroundColor(Color.Pink)
          .width(200)
          .height(50)
          .margin({ left: 15, right: 15 })
          .onChange((value: string) => {

          })
          .onFocus(() => {

          })
        TextInput({ placeholder: '请输入密码' })
          .type(InputType.Password)
          .enterKeyType(EnterKeyType.Go)
          .backgroundColor(Color.Pink)
          .width(200)
          .height(50)
          .margin({ top: 15, left: 15, right: 15 })
          .onSubmit((enterKey: EnterKeyType) => {
            promptAction.showToast({ message: enterKey + '' })
          })

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
          .decoration({//设置文本装饰线类型样式及其颜色。
            type:TextDecorationType.Underline,
            color:Color.Red,
            style:TextDecorationStyle.DOTTED
          })
          .wordBreak(WordBreak.BREAK_WORD)

      }.width('100%')
    }
    .width('100%')
  }
}