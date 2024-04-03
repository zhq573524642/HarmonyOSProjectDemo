import { CommonButton } from './component/MyComponent'

@Entry
@Component
struct VideoPlayPage {
  private videoSrc: Resource = $rawfile('video.mp4')
  private videoPreviewUri = $r('app.media.ic_video_preview')
  private videoController: VideoController = new VideoController()
  @State isMuted: boolean = false;
  @State isPlaying: boolean = false
  @State curPlayRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State curPlayRateDesc: string = '1.0倍速'
  @State isShowDefaultControls: boolean = true
  @State isAutoPlay: boolean = false
  @State isLoop: boolean = false
  @State isStop: boolean = false
  @State objectFit: ImageFit = ImageFit.Contain
  @State objectFitDesc: string = 'ImageFit.Contain'
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        Video({ src: this.videoSrc,
          previewUri: this.videoPreviewUri,
          currentProgressRate: this.curPlayRate,
          controller: this.videoController })
          .muted(this.isMuted) //是否静音
          .controls(this.isShowDefaultControls) //是否默认显示控制条
          .autoPlay(this.isAutoPlay) //是否自动播放
          .loop(this.isLoop) //是否循环播放
          .objectFit(this.objectFit) //设置视频适配模式
          .width('100%')
          .height(300)
          .onPrepared((event) => {
            console.info('====onPrepared')
          })
          .onStart(() => {
            console.info('====onStart')
          })
          .onUpdate((event) => {
            console.info('====onUpdate')
          })
          .onError(() => {
            console.info('====onError')
          })
          .onPause(() => {
            console.info('====onPause')
          })
          .onFinish(() => {
            console.info('====onFinish')
          })
        Button(this.objectFitDesc)
          .borderRadius(8)
          .margin(10)
          .width('100%')
          .height(40)
          .fontColor(Color.Black)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            if (this.objectFit == ImageFit.Contain) {
              this.objectFit = ImageFit.Cover
              this.objectFitDesc = 'ImageFit.Cover'
            } else if (this.objectFit == ImageFit.Cover) {
              this.objectFit = ImageFit.Auto
              this.objectFitDesc = 'ImageFit.Auto'
            } else if (this.objectFit == ImageFit.Auto) {
              this.objectFit = ImageFit.Fill
              this.objectFitDesc = 'ImageFit.Fill'
            } else if (this.objectFit == ImageFit.Fill) {
              this.objectFit = ImageFit.ScaleDown
              this.objectFitDesc = 'ImageFit.ScaleDown'
            } else if (this.objectFit == ImageFit.ScaleDown) {
              this.objectFit = ImageFit.None
              this.objectFitDesc = 'ImageFit.None'
            } else if (this.objectFit == ImageFit.None) {
              this.objectFit = ImageFit.Contain
              this.objectFitDesc = 'ImageFit.Contain'
            }
          })
        Button(this.isPlaying ? '暂停' : '播放')
          .borderRadius(8)
          .margin(10)
          .width('100%')
          .height(40)
          .fontColor(Color.Black)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            if (this.isPlaying) {
              this.videoController.pause()
            } else {
              this.videoController.start()
              this.isStop = false
            }
            this.isPlaying = !this.isPlaying
          })
        Button(this.isStop ? '已停止' : '点击停止')
          .borderRadius(8)
          .margin(10)
          .width('100%')
          .height(40)
          .fontColor(Color.Black)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            if (!this.isStop) {
              this.videoController.stop()
              this.isPlaying = false
              this.isStop = true
            }
          })
        Button(this.isShowDefaultControls ? '是否显示默认控制：已显示' : '是否显示默认控制：已隐藏')
          .borderRadius(8)
          .margin(10)
          .width('100%')
          .height(40)
          .fontColor(Color.Black)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            this.isShowDefaultControls = !this.isShowDefaultControls
          })
        Button(this.isAutoPlay ? '是否自动播放：自动播放' : '是否自动播放：不自动播放')
          .borderRadius(8)
          .margin(10)
          .width('100%')
          .height(40)
          .fontColor(Color.Black)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            this.isAutoPlay = !this.isAutoPlay
          })
        Button(this.isMuted ? '已静音' : '已取消静音')
          .borderRadius(8)
          .margin(10)
          .fontColor(Color.Black)
          .width('100%')
          .height(40)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            this.isMuted = !this.isMuted
          })
        Button(this.isLoop ? '已开启循环播放' : '已关闭循环播放')
          .borderRadius(8)
          .margin(10)
          .fontColor(Color.Black)
          .width('100%')
          .height(40)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            this.isLoop = !this.isLoop
          })
        Button('倍速：' + this.curPlayRateDesc)
          .borderRadius(8)
          .margin(10)
          .fontColor(Color.Black)
          .width('100%')
          .height(40)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            if (this.curPlayRate == PlaybackSpeed.Speed_Forward_1_00_X) {
              this.curPlayRateDesc = '1.25倍速'
              this.curPlayRate = PlaybackSpeed.Speed_Forward_1_25_X
            } else if (this.curPlayRate == PlaybackSpeed.Speed_Forward_1_25_X) {
              this.curPlayRateDesc = '1.75倍速'
              this.curPlayRate = PlaybackSpeed.Speed_Forward_1_75_X
            } else if (this.curPlayRate == PlaybackSpeed.Speed_Forward_1_75_X) {
              this.curPlayRateDesc = '2.0倍速'
              this.curPlayRate = PlaybackSpeed.Speed_Forward_2_00_X
            } else if (this.curPlayRate == PlaybackSpeed.Speed_Forward_2_00_X) {
              this.curPlayRateDesc = '1.0倍速'
              this.curPlayRate = PlaybackSpeed.Speed_Forward_1_00_X
            }
          })
        Button('跳转到视频10s位置')
          .borderRadius(8)
          .margin(10)
          .fontColor(Color.Black)
          .width('100%')
          .height(40)
          .backgroundColor(Color.Pink)
          .onClick(() => {
            this.videoController.setCurrentTime(10, SeekMode.Accurate)
          })


      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)
  }
}

