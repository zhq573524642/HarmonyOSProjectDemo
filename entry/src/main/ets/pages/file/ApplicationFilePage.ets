import { CommonButton } from '../component/MyComponent'
import fileIo, { ReadOptions, WriteOptions } from '@ohos.file.fs'
import { common, Want, wantConstant } from '@kit.AbilityKit'
import buffer from '@ohos.buffer'
import { BusinessError } from '@kit.BasicServicesKit'
import { DateUtil, ToastUtils } from '@ohos/common'
import hash from '@ohos.file.hash'
import { fileUri } from '@kit.CoreFileKit'

@Entry
@Component
struct FileHandlePage {
  private context = getContext(this) as common.UIAbilityContext
  @State fileContent: string = ''
  @State inputContent: string = ''

  build() {
    Column({ space: 10 }) {
      TextInput({ placeholder: '请输入', text: $$this.inputContent })
        .width('80%')
        .height(50)
      CommonButton({ text: '创建文件并读写' })
        .onClick(() => {
          this.createFileSync()
        })
      CommonButton({ text: '读取文件内容并写入另一文件' })
        .onClick(() => {
          this.readWriteFileSync()
        })
      CommonButton({ text: '获取文件详细信息' })
        .onClick(() => {
          this.getFileDetailsByStat()
        })

      Text(this.fileContent).fontSize(16)
        .fontColor(Color.Blue)
      CommonButton({ text: '以流的形式读写文件' })
        .onClick(() => {
          this.readWriteFileWithStream()
        })
      CommonButton({ text: '文件可读流、文件可写流' })
        .onClick(() => {
          this.copyFileWithReadable()
          // this.copyFileWithData()
        })
      CommonButton({ text: '使用文件哈希流' })
        .onClick(() => {
          this.hashFileWithStream()
        })

      CommonButton({ text: '应用文件分享' })
        .onClick(() => {
          this.shareFile()
        })
    }.width('100%')
  }

  createFileSync() {
    // 新建并打开文件
    let filesDir = this.context.filesDir;
    let file = fileIo.openSync(filesDir + '/sync_test.txt', fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
    // 写入一段内容至文件

    let writeLen = fileIo.writeSync(file.fd, this.inputContent);
    console.debug("===The length of str is: " + writeLen);
    // 从文件读取一段内容
    let arrayBuffer = new ArrayBuffer(2048);
    let readOptions: ReadOptions = {
      offset: 0,
      length: arrayBuffer.byteLength
    };
    let readLen = fileIo.readSync(file.fd, arrayBuffer, readOptions);
    let buf = buffer.from(arrayBuffer, 0, readLen);
    this.fileContent = buf.toString()
    // 关闭文件
    fileIo.closeSync(file);
  }

  readWriteFileSync() {
    let fileDir = this.context.filesDir
    let srcFile = fileIo.openSync(fileDir + '/sync_test.txt', fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE)
    let destFile = fileIo.openSync(fileDir + '/sync_test_dest.txt', fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE)
    let bufSize = 2048
    let readOffset = 0
    let buf = new ArrayBuffer(bufSize)
    let readOptions: ReadOptions = {
      offset: readOffset,
      length: bufSize
    }

    let readLen = fileIo.readSync(srcFile.fd, buf, readOptions)
    while (readLen > 0) {
      readOffset += readLen
      let writeOptions: WriteOptions = {
        length: readLen
      }
      fileIo.write(destFile.fd, buf, writeOptions)
      readOptions.offset = readOffset
      readLen = fileIo.readSync(srcFile.fd, buf, readOptions);
    }
    fileIo.closeSync(srcFile)
    // 从文件读取一段内容
    let arrayBuffer = new ArrayBuffer(2048);
    let readDestOptions: ReadOptions = {
      offset: 0,
      length: arrayBuffer.byteLength
    };
    let rl = fileIo.readSync(destFile.fd, arrayBuffer, readDestOptions);
    let destBuf = buffer.from(arrayBuffer, 0, rl);
    this.fileContent = '目标文件内容:' + destBuf.toString()
    fileIo.closeSync(destFile)
  }

  getFileDetailsByStat() {
    fileIo.stat(this.context.filesDir + '/sync_test.txt')
      .then((stat: fileIo.Stat) => {
        let ino = stat.ino //标识该文件。通常同设备上的不同文件的INO不同。
        let mode = stat.mode //表示文件权限，各特征位的含义
        let uid = stat.uid //文件所有者id
        let gid = stat.gid //文件所有组id
        let size = stat.size //文件的大小，以字节为单位。仅对普通文件有效。
        let atime = stat.atime //上次访问该文件的时间，表示距1970年1月1日0时0分0秒的秒数。
        let mtime = stat.mtime //上次修改该文件的时间，表示距1970年1月1日0时0分0秒的秒数。
        let ctime = stat.ctime //最近改变文件状态的时间，表示距1970年1月1日0时0分0秒的秒数。
        let location = stat.location //文件的位置，表示该文件是本地文件或者云端文件。
        let isBlockDevice = stat.isBlockDevice() //用于判断文件是否是块特殊文件。一个块特殊文件只能以块为粒度进行访问，且访问的时候带缓存。
        let isCharacterDevice = stat.isCharacterDevice() //用于判断文件是否是字符特殊文件。一个字符特殊设备可进行随机访问，且访问的时候不带缓存
        let isDirectory = stat.isDirectory() //用于判断文件是否是目录。
        let isFIFO = stat.isFIFO() //用于判断文件是否是命名管道（有时也称为FIFO）。命名管道通常用于进程间通信。
        let isFile = stat.isFile() //用于判断文件是否是普通文件。
        let isSocket = stat.isSocket() //用于判断文件是否是套接字。
        let isSymbolicLink = stat.isSymbolicLink() //用于判断文件是否是符号链接
        this.fileContent =
          'ino:' + ino + '\n' +
            'mode:' + mode + '\n' +
            'uid:' + uid + '\n' +
            'gid:' + gid + '\n' +
            'size:' + size + '\n' +
            '上次访问该文件的时间:' + DateUtil.getTipDateStr(atime) + '\n' +
            '上次修改该文件的时间:' + DateUtil.getTipDateStr(mtime) + '\n' +
            '最近改变文件状态的时间:' + DateUtil.getTipDateStr(ctime) + '\n' +
            'location:' + location + '\n' +
            '文件是否是块特殊文件：' + isBlockDevice + '\n' +
            '文件是否是字符特殊文件：' + isCharacterDevice + '\n' +
            '文件是否目录：' + isDirectory + '\n' +
            '文件是否是命名管道：' + isFIFO + '\n' +
            '文件是否是普通文件：' + isFile + '\n' +
            '文件是否是套接字：' + isSocket + '\n' +
            '文件是否是符号链接：' + isSymbolicLink
      })
  }

  async readWriteFileWithStream(): Promise<void> {
    // 打开文件流
    let filesDir = this.context.filesDir
    let inputStream = fileIo.createStreamSync(filesDir + '/sync_test.txt', 'r+');
    let outputStream = fileIo.createStreamSync(filesDir + '/destFile.txt', "w+");
    // 以流的形式读取源文件内容并写入目的文件
    let bufSize = 4096;
    let readSize = 0;
    let buf = new ArrayBuffer(bufSize);
    let readOptions: ReadOptions = {
      offset: readSize,
      length: bufSize
    };
    let readLen = await inputStream.read(buf, readOptions);
    readSize += readLen;
    while (readLen > 0) {
      const writeBuf = readLen < bufSize ? buf.slice(0, readLen) : buf;
      await outputStream.write(writeBuf);
      readOptions.offset = readSize;
      readLen = await inputStream.read(buf, readOptions);
      readSize += readLen;
    }
    // 关闭文件流
    inputStream.closeSync();
    readOptions.offset = 0
    readOptions.length = bufSize
    let readBuf = new ArrayBuffer(bufSize);
    let len = await outputStream.read(readBuf, readOptions)
    let result = buffer.from(readBuf, 0, len)
    this.fileContent = '流形式：' + result.toString()
    outputStream.closeSync();
  }

  copyFileWithReadable(): void {
    // 创建文件可读流
    let filesDir = this.context.filesDir
    const rs = fileIo.createReadStream(`${filesDir}/sync_test.txt`);
    // 创建文件可写流
    const ws = fileIo.createWriteStream(`${filesDir}/write1.txt`);
    // 暂停模式拷贝文件
    rs.on('readable', () => {
      const data = rs.read();
      if (!data) {
        return;
      }
      ws.write(data);
    });
  }

  copyFileWithData(): void {
    let filesDir = this.context.filesDir
    // 创建文件可读流
    const rs = fileIo.createReadStream(`${filesDir}/sync_test.txt`);
    // 创建文件可写流
    const ws = fileIo.createWriteStream(`${filesDir}/write2.txt`);
    // 流动模式拷贝文件
    rs.on('data', (emitData) => {
      const data = emitData?.data;
      if (!data) {
        return;
      }
      ws.write(data as Uint8Array);
    });
  }

  hashFileWithStream() {
    let filesDir = this.context.filesDir
    const filePath = `${filesDir}/test.txt`;
    // 创建文件可读流
    const rs = fileIo.createReadStream(filePath);
    // 创建哈希流
    const hs = hash.createHash('sha256');
    rs.on('data', (emitData) => {
      const data = emitData?.data;
      hs.update(new Uint8Array(data?.split('').map((x: string) => x.charCodeAt(0))).buffer);
    });
    rs.on('close', async () => {
      const hashResult = hs.digest();
      const fileHash = await hash.hash(filePath, 'sha256');
      this.fileContent = `hashResult: ${hashResult}, fileHash: ${fileHash}`
    });
  }

  shareFile() {
    let filesDir = this.context.filesDir
    let uri = fileUri.getUriFromPath(filesDir+'/sync_test.txt')
    let want: Want = {
      //配置读写权限
      flags: wantConstant.Flags.FLAG_AUTH_WRITE_URI_PERMISSION | wantConstant.Flags.FLAG_AUTH_READ_URI_PERMISSION,
      // 配置分享应用的隐式拉起规则
      action: 'ohos.want.action.sendData',
      uri: uri,
      type: 'text/plain', //分享类型
    }
    this.context.startAbility(want)
      .then(() => {
        ToastUtils.show('分享成功')
      })
      .catch((error: BusinessError) => {
        ToastUtils.show('分享失败：' + error.message)
      })
  }
}