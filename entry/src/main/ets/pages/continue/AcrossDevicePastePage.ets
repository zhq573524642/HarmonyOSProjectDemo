import { CommonButton } from "../component/MyComponent"
import pasteboard from "@ohos.pasteboard"
import { BusinessError } from "@kit.BasicServicesKit"
import { RouterUtil } from "@ohos/common"

@Entry({routeName:"AcrossDevicePastePage"})
@ComponentV2
export struct AcrossDevicePastePage {
  @Local inputText: string = ''
  @Local pasteContent: string = ''

  static  startPage(){
    RouterUtil.pushNamedRoute('AcrossDevicePastePage')
  }


  build() {
    Column() {
      TextInput({
        text: $$this.inputText
      })
        .width('90%')
        .height(50)
      CommonButton({ text: '复制文本' })
        .onClick(() => {
          this.setTestPasteData(this.inputText)
        })

      Text(this.pasteContent)
        .fontColor(Color.Red)
        .fontSize(16)
      CommonButton({ text: '获取剪切板内容' })
        .onClick(() => {
          this.getTestPasteData()
        })
    }
  }

  async setTestPasteData(data: string): Promise<void> {
    //构建剪切板数据
    let pasteData: pasteboard.PasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, data)
    //获取系统剪切板
    let systemPasteBoard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
    await systemPasteBoard.setData(pasteData).catch((err: BusinessError) => {
      console.error(`===Failed to set pastedata. Code: ${err.code}, message: ${err.message}`);
    });
  }

  async getTestPasteData(): Promise<void> {
    let systemPasteBoard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard();
    systemPasteBoard.getData((err: BusinessError, data: pasteboard.PasteData) => {
      if (err) {
        console.error(`===Failed to get pastedata. Code: ${err.code}, message: ${err.message}`);
        return;
      }
      // 对pastedata进行处理，获取类型，个数等
      let recordCount: number = data.getRecordCount(); // 获取剪贴板内record的个数
      let types: string = data.getPrimaryMimeType(); // 获取剪贴板内数据的类型
      let primaryText: string = data.getPrimaryText(); // 获取剪贴板内数据的内容
      this.pasteContent = `剪切板记录条数：${recordCount}-数据类型：${types}-内容：${primaryText}`
    });
  }
}