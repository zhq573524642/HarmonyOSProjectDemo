import { CommonButton, CommonTitle } from '../component/MyComponent'
import fileIo from '@ohos.file.fs'
import { BusinessError } from '@kit.BasicServicesKit'
import { common } from '@kit.AbilityKit'
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils'
import { taskpool } from '@kit.ArkTS'

@Entry
@Component
struct ConcurrencyPage {
  @State inputText: string = ''

  build() {
    Column({ space: 10 }) {
      CommonTitle({ title: '异步并发：Promise和async/await' })
      TextInput({
        text: $$this.inputText,
        placeholder: '请输入'
      })
        .width('80%')
        .height(50)
        .borderColor(Color.Gray)
        .backgroundColor('#f5f5f5')
        .borderRadius(15)
      CommonButton({ text: '使用Promise和async/await写文件惭怍' })
        .onClick(async () => {
          let result = await this.handleWrite(this.inputText)
          ToastUtils.show(result ? '写入成功' : '写入失败')
        })
      CommonTitle({ title: '多线程并发：TaskPool和Worker' })
    }.width('100%')
  }

  //写操作
  async writeText(text: string, file: fileIo.File): Promise<void> {
    fileIo.write(file.fd, text)
      .then((writeLen: number) => {
        console.debug('===写文件长度：' + writeLen)
      })
      .catch((error: BusinessError) => {
        console.debug('===写文件错误：' + error.message)
      })
  }

  //读文件
  // async readText(file: fileIo.File){
  //   fileIo.read(file.fd)
  //     .then()
  // }

  async handleWrite(text: string): Promise<boolean> {
    let context = getContext() as common.UIAbilityContext;
    let filePath: string = context.filesDir + "/test.txt"; // 应用文件路径
    let file: fileIo.File = await fileIo.open(filePath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
    this.writeText(text, file)
      .then(() => {
        console.debug('===Succeeded in writing data.');
        fileIo.close(file);
      }).catch((err: BusinessError) => {
      console.debug(`===Failed to write data. Code is ${err.code}, message is ${err.message}`);
      fileIo.close(file);
    })
    let result = await fileIo.access(filePath, fileIo.AccessModeType.EXIST);
    if (!result) {
      return false;
    }
    return true;
  }

  handleTaskPool() {
    let taskGroup: taskpool.TaskGroup = new taskpool.TaskGroup();

  }
}