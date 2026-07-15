import { display, Size } from '@kit.ArkUI'
import { BlockPuzzleModel } from './BlockPuzzleModel'
import blockPuzzleViewModel from './BlockPuzzleViewModel'

let controller: CustomDialogController | null

@Component
export struct BlockPuzzleDialog {
  build() {
  }

  showAlockPuzzle(callback: (verify: string) => void, widthScale: number = 90) {
    controller = new CustomDialogController({
      builder: BlockPuzzleDialogView({
        widthScale: widthScale,
        success: callback
      }),
      alignment: DialogAlignment.Center,
      customStyle: true,
      cornerRadius: {
        topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0
      },
      autoCancel: false
    })
    controller.open()
  }
}

enum ResultType {
  normal = '#337AB7',
  check = '#337AB7',
  success = '#4cae4c',
  failure = '#d9534f'
}

@CustomDialog
struct BlockPuzzleDialogView {
  widthScale: number = 100
  customController?: CustomDialogController
  success?: (verity: string) => void
  // 滑动位置
  @State private offsetX: number = 0
  // 图片占位大小
  private imageSize: Size = { width: 400, height: 200 }
  // 滑动控件大小
  private scrollViewSize: Size = { width: 400, height: 50 }
  // 内间距
  private viewPadding: number = 10
  // 记录滑动开始位置
  private touchPoint: number = -1
  // 刷新按钮大小
  private refreshSize: Size = { width: 33, height: 33 }
  // 图片信息
  @State private puzzleData: BlockPuzzleModel = new BlockPuzzleModel()
  // 警告窗口
  @State private resultType: ResultType = ResultType.normal
  // 结果展示条
  @State resultBlockTop: number = 0
  // 记录图片比例，用来提交时候计算使用
  private loadImageWidth: number = 0
  // 记录点击时间，成功时候提示需要计算时间
  @State private touchTime: number = 0

  // 需要新增的
  @State private jigsawDisplayWidth: number = 50   // 拼图块显示宽度，初始 fallback
  @State private jigsawDisplayHeight: number = 50  // 拼图块显示高度，初始 fallback
  private loadImageHeight: number = 0              // 原图原始像素高度
  private jigsawOrigWidth: number = 0              // 拼图块原始像素宽度
  private jigsawOrigHeight: number = 0             // 拼图块原始像素高度


  private updateJigsawDisplaySize() {
    if (this.loadImageWidth > 0 && this.jigsawOrigWidth > 0) {
      let scale = this.imageSize.width / this.loadImageWidth
      this.jigsawDisplayWidth = this.jigsawOrigWidth * scale
      this.jigsawDisplayHeight = this.jigsawOrigHeight * scale
    }
  }


  // 宽度转化
  private transformWidth() {
    return `${this.widthScale}%`
  }

  aboutToAppear(): void {
    this.widthScale = Math.max(0, Math.min(100, this.widthScale))
    let maxWidth = px2vp(display.getDefaultDisplaySync().width) * (this.widthScale / 100) - 20
    this.imageSize = { width: maxWidth, height: maxWidth / 2 }
    this.scrollViewSize = { width: maxWidth, height: 50 }
    this.requestCheckData()
  }

  // 请求图片数据
  private requestCheckData() {
    // 请求数据
    blockPuzzleViewModel.getPuzzleImage().then((puzzleData: BlockPuzzleModel) => {
      puzzleData.originalImageBase64 = 'data:image/png;base64,' + puzzleData.originalImageBase64
      puzzleData.jigsawImageBase64 = 'data:image/png;base64,' + puzzleData.jigsawImageBase64
      //重置
      this.jigsawDisplayWidth = 50
      this.jigsawDisplayHeight = 50
      this.jigsawOrigWidth = 0
      this.jigsawOrigHeight = 0

      this.puzzleData = puzzleData
    })
  }

  // 接口校验位置
  private checkPoint() {
    this.resultType = ResultType.check
    blockPuzzleViewModel.checkPuzzle(this.offsetX * (this.loadImageWidth / this.imageSize.width), this.puzzleData)
      .then((buzzleResult) => {
        this.resultType = ResultType.success
        this.checkScrollPoint(false, buzzleResult)
      }).catch((error: string) => {
      this.resultType = ResultType.failure
      this.checkScrollPoint()
    })
  }

  // 验证滑动位置
  private checkScrollPoint(again: boolean = true, verify: string = '') {
    this.resultBlockTop = this.imageSize.height
    animateTo({
      duration: 1000,
      onFinish: () => {
        if (again) {
          animateTo({
            duration: 1000,
            delay: 300,
            onFinish: () => {
              this.requestCheckData()
              this.resultType = ResultType.normal
              this.touchPoint = -1
              animateTo({
                duration: 300
              }, () => {
                this.offsetX = 0
              })
            }
          }, () => {
            this.resultBlockTop = this.imageSize.height
          })
        } else {
          this.customController?.close()
          this.success ? this.success(verify) : false
          controller = null
        }
      }
    }, () => {
      this.resultBlockTop = this.imageSize.height - 44
    })
  }

  private handleTouchEvent(event: TouchEvent) {
    // 点击位置
    if (event.touches.length <= 0 || this.resultType != ResultType.normal) {
      return
    }
    let touch = event.touches[0]
    let offset = Math.min(touch.x, this.imageSize.width - this.scrollViewSize.height + (this.touchPoint == -1 ? 0 : this.touchPoint))
    if (this.touchPoint != -1) {
      offset = Math.max(offset, this.touchPoint)
    }
    switch (event.type) {
      case TouchType.Down:
      // 记录时间开始验证
        if (this.touchPoint == -1 && offset <= this.scrollViewSize.height) {
          this.touchPoint = offset
          this.touchTime = Date.now()
        }
        break
      case TouchType.Move:
      // this.offsetX += (offset - this.touchPoint)
        if (this.touchPoint != -1) {
          this.offsetX = offset - this.touchPoint
        }
        break
      default:
        if (this.touchPoint != -1) {
          this.touchTime = Date.now() - this.touchTime
          this.checkPoint()
        }
        break
    }
  }

  build() {
    Column({ space: 10 }) {
      Column() {
        Row() {
          Text('请完成安全验证')
            .dialogTextStyle()

          Button() {
            Image($r('app.media.white_back'))
              .squareImage(20)
          }
          .backgroundColor('#33000000')
          .squareButton(24)
          .onClick(() => {
            this.customController?.close()
            controller = null
          })
        }
        .fullComponent()
        .justifyContent(FlexAlign.SpaceBetween)

        Divider().backgroundColor('#66000000')
      }
      .width('100%')
      .height(40)
      .backgroundColor(Color.White)

      Stack() {
        Image(this.puzzleData.originalImageBase64)
          .objectFit(ImageFit.Auto)
          .fullComponent()
          .onComplete((event) => {
            // if (event) {
            //   this.loadImageWidth = event.width
            // }
            if (event) {
              this.loadImageWidth = event.width
              this.loadImageHeight = event.height
              this.updateJigsawDisplaySize()
            }
          })

        // Image(this.puzzleData.jigsawImageBase64)
        //   .objectFit(ImageFit.Auto)
        //   .width(this.scrollViewSize.height)
        //   .height('100%')
        //   .position({ x: this.offsetX })

        Image(this.puzzleData.jigsawImageBase64)
          .objectFit(ImageFit.Fill)
          .width(this.jigsawDisplayWidth)      // 动态计算
          .height(this.jigsawDisplayHeight)    // 动态计算
          .position({ x: this.offsetX })
          .onComplete((event) => {
            if (event) {
              this.jigsawOrigWidth = event.width
              this.jigsawOrigHeight = event.height
              this.updateJigsawDisplaySize()
            }
          })

        Row() {
          Image($r('app.media.puzzleRefresh'))
            .squareImage(20)
            .objectFit(ImageFit.Auto)
        }
        .alignItems(VerticalAlign.Center)
        .width(this.refreshSize.width)
        .height(this.refreshSize.height)
        .position({ x: this.imageSize.width - this.refreshSize.width, y: 0 })
        .onClick(this.requestCheckData.bind(this))

        Text(this.resultType == ResultType.success ? `${(this.touchTime / 1000).toFixed(2)}s验证成功` : '验证失败')
          .fontSize(16)
          .fontColor(Color.White)
          .textAlign(TextAlign.Start)
          .backgroundColor(`#66${this.resultType.replace('#', '')}`)
          .childComponent()
          .position({ x: 0, y: this.resultBlockTop })
          .visibility(this.resultType == ResultType.normal ? Visibility.Hidden : Visibility.Visible)
      }
      .width('100%')
      .height(this.imageSize.height)
      .clip(true)

      Row() {
        Text("向右滑动完成验证")
          .fullComponent()
          .dialogTextStyle()
          .textAlign(TextAlign.Center)
          .visibility(this.offsetX > 0 ? Visibility.Hidden : Visibility.Visible)

        Row()
          .borderWidth(4)
          .borderColor(this.resultType)
          .width(this.offsetX + 1)
          .height(this.scrollViewSize.height)
          .position({ x: 0, y: 0 })
          .backgroundColor('#B6E98E')

        Text('>')
          .width(this.scrollViewSize.height)
          .height(this.scrollViewSize.height)
          .borderRadius(2)
          .borderColor("#EEEEEE")
          .borderWidth(2)
          .textAlign(TextAlign.Center)
          .position({ x: this.offsetX })
          .backgroundColor(Color.White)
      }
      .height(this.scrollViewSize.height)
      .width('100%')
      .borderRadius(2)
      .borderColor("#EEEEEE")
      .borderWidth(2)
      .justifyContent(FlexAlign.Start)
      .onTouch(this.handleTouchEvent.bind(this))
    }
    .width(this.transformWidth())
    .id('customDialogForImageCheck')
    .padding(this.viewPadding)
    .height(40 + 20 + this.imageSize.height + this.scrollViewSize.height + this.viewPadding * 2)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }
}

// 占父控件整个部分大
@Styles
function fullComponent() {
  .width('100%')
  .height('100%')
}

// 宽度相同高度40
@Styles
function childComponent() {
  .width('100%')
  .height(44)
}

// 正方形 - 图片
@Extend(Image)
function squareImage(size: number) {
  .width(size)
  .height(size)
}

// 正方形 - 按钮
@Extend(Button)
function squareButton(size: number) {
  .width(size)
  .height(size)
}

// 弹窗文字样式
@Extend(Text)
function dialogTextStyle() {
  .fontSize(18)
  .fontColor($r('app.color.color_333333'))
  .backgroundColor(Color.White)
}