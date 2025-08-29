import { util } from '@kit.ArkTS';
import fileStream from '@ohos.file.fs';

const helper = new util.Base64Helper();

export let filePath : string;
export const fileName = 'demoFile.txt';
export namespace  DownloadUtils {

  export function init(context: UIContext): void {
    filePath = context.getHostContext()!.filesDir;
  }

  export function uint8ArrayToStr(uint8Array: Uint8Array): string {
    return helper.encodeToStringSync(uint8Array);
  }

  export function strToUint8Array(str: string): Uint8Array {
    return helper.decodeSync(str);
  }

  export function saveDownloadInfo(downloadInfo: string): void {
    if (!fileExists(filePath)) {
      mkDirectorySync(filePath);
    }

    writeToFileSync(filePath, fileName, downloadInfo);
  }

  export function fileExists(filePath: string): boolean {
    try {
      return fileStream.accessSync(filePath);
    } catch (error) {
      return false;
    }
  }

  export function mkDirectorySync(directoryPath: string, recursion?: boolean): void {
    try {
      fileStream.mkdirSync(directoryPath, recursion ?? false);
    } catch (error) {
      console.error(`mk dir error. err message: ${error.message}, err code: ${error.code}`);
    }
  }

  export function writeToFileSync(dir: string, fileName: string, msg: string): void {
    let file = fileStream.openSync(dir + '/' + fileName, fileStream.OpenMode.WRITE_ONLY | fileStream.OpenMode.CREATE);
    fileStream.writeSync(file.fd, msg);
  }

  export function readFileSync(dir: string, fileName: string): string {
    return fileStream.readTextSync(dir + '/' + fileName);
  }

}