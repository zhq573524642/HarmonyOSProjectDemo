@Component
export struct GradientBorderContainer {
  @State borWidth: number = 200; // 边框宽度
  @State borHeight: number = 160; // 边框高度
  @State borLen: number = 1; // 边框粗细
  @State radiusLen: number = 8; // 边框圆角
  @State sweepStartDeg: number = 0 // 角度渐变的起点
  @State sweepEndDeg: number = 360 //角度渐变的终点。
  @State sweepRotationDeg: number | string = '90deg' // 渐变色起点旋转角度
  @State gradientColors: Array<[ResourceColor, number]> = [
  // 当前组件中，按照中心点和渐变的起点和终点值,
  // todo 添加0°的时候颜色值
    ['#FEA42A', 0 / 360],
    ['#FC7334', 34 / 360],
    ['#DE67FF', 104 / 360],
    ['#2EBBFE', 200 / 360],
    ['#3EF14B', 307 / 360],
    ['#FEA42A', 360 / 360],
  ]
  @BuilderParam contentView?: () => void

  build() {
    Stack() {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {}
      .sweepGradient({
        center: [this.borWidth / 2, this.borHeight / 2],
        start: this.sweepStartDeg,
        end: this.sweepEndDeg, //
        rotation: this.sweepRotationDeg,
        // repeating: true, // 重复渲染 -- 如果渲染值从0-360，可以不重复
        colors: this.gradientColors
      })
      .borderRadius(this.radiusLen)
      .width(this.borWidth)
      .height(this.borHeight);

      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
        //此处实现内容展示
        if (this.contentView) {
          this.contentView()
        }
      }
      .borderRadius(this.radiusLen)
      .backgroundColor(Color.White)
      // .margin({ left: this.borLen, top: this.borLen })
      .width(this.borWidth - 2 * this.borLen)
      // .height(this.borHeight - 2 * this.borLen);
      //设置Flex高度为auto，根据内容的高度自适应Flex高度
      .height('auto')
      // 监听Flex高度的变化，然后设置border的高度
      .onAreaChange((oldValue: Area, newValue: Area) => {
        if (typeof newValue.height === 'number') {
          //border的高度要比Flex内容的高度多出上下两条border线的宽度
          this.borHeight = Number(newValue.height) + 2 * this.borLen;
        }
      })
    }
    .width(this.borWidth);
    // .height(this.borHeight);
  }
}