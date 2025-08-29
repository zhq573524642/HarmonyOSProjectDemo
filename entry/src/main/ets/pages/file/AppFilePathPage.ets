import { common } from '@kit.AbilityKit'
import { LengthMetrics } from '@kit.ArkUI'

@Entry
@Component
struct AppFilePathPage {
  private context = getContext(this) as common.UIAbilityContext
  private scroller: Scroller = new Scroller()
  @State paths: string = ''

  build() {
    Scroll(this.scroller) {
      Column() {
        Text(this.paths)
          .fontSize(16)
          .lineSpacing(LengthMetrics.vp(6))
      }.width('100%')
    }.width('100%')
  }

  aboutToAppear(): void {
    let applicationContext = this.context.getApplicationContext()
    let cacheDir = applicationContext.cacheDir;
    let tempDir = applicationContext.tempDir;
    let filesDir = applicationContext.filesDir;
    let databaseDir = applicationContext.databaseDir;
    let bundleCodeDir = applicationContext.bundleCodeDir;
    let distributedFilesDir = applicationContext.distributedFilesDir;
    let preferencesDir = applicationContext.preferencesDir;
    let cloudFileDir = applicationContext.cloudFileDir;

    let cacheDir1 = this.context.cacheDir;
    let tempDir1 = this.context.tempDir;
    let filesDir1 = this.context.filesDir;
    let databaseDir1 = this.context.databaseDir;
    let bundleCodeDir1 = this.context.bundleCodeDir;
    let distributedFilesDir1 = this.context.distributedFilesDir;
    let preferencesDir1 = this.context.preferencesDir;
    let cloudFileDir1 = applicationContext.cloudFileDir;
    this.paths = '通过ApplicationContext获取应用级别的应用文件路径\n'
      + 'cacheDir:' + cacheDir + '\n'
      + 'tempDir:' + tempDir + '\n'
      + 'filesDir:' + filesDir + '\n'
      + 'databaseDir:' + databaseDir + '\n'
      + 'bundleCodeDir:' + bundleCodeDir + '\n'
      + 'distributedFilesDir:' + distributedFilesDir + '\n'
      + 'preferencesDir:' + preferencesDir + '\n'
      + 'cloudFileDir:' + cloudFileDir + '\n\n'
      +'通过UiAbilityContext获取应用级别的应用文件路径\n'
      + 'cacheDir:' + cacheDir1 + '\n'
      + 'tempDir:' + tempDir1 + '\n'
      + 'filesDir:' + filesDir1 + '\n'
      + 'databaseDir:' + databaseDir1 + '\n'
      + 'bundleCodeDir:' + bundleCodeDir1 + '\n'
      + 'distributedFilesDir:' + distributedFilesDir1 + '\n'
      + 'preferencesDir:' + preferencesDir1 + '\n'
      + 'cloudFileDir:' + cloudFileDir1 + '\n'
  }
}