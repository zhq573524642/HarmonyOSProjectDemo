import { CommonButton1 } from '../component/MyComponent'

@Entry
@Component
struct FlexPage {
  //布局方向
  @State directionState: FlexDirection = FlexDirection.Row
  @State directionDesc: string = '布局方向FlexDirection.Row'
  //布局换行
  @State flexWrap: FlexWrap = FlexWrap.NoWrap
  @State flexWrapDesc: string = '布局换行FlexWrap.NoWrap'
  //主轴对齐
  @State justifyContent: FlexAlign = FlexAlign.Start
  @State justifyContentDesc: string = '主轴对齐方式FlexAlign.Start'
  //交叉轴对齐
  @State itemAlign: ItemAlign = ItemAlign.Auto
  @State itemAlignDesc: string = '交叉轴对齐ItemAlign.Auto'

  build() {
    Column() {
      CommonButton1({ text: $directionDesc }).onClick(() => {
        if (this.directionState == FlexDirection.Row) {
          this.directionState = FlexDirection.RowReverse
          this.directionDesc = '布局方向FlexDirection.RowReverse'
        } else if (this.directionState == FlexDirection.RowReverse) {
          this.directionState = FlexDirection.Column
          this.directionDesc = '布局方向FlexDirection.Column'
        } else if (this.directionState == FlexDirection.Column) {
          this.directionState = FlexDirection.ColumnReverse
          this.directionDesc = '布局方向FlexDirection.ColumnReverse'
        } else if (this.directionState == FlexDirection.ColumnReverse) {
          this.directionState = FlexDirection.Row
          this.directionDesc = '布局方向FlexDirection.Row'
        }
      })
      CommonButton1({ text: $flexWrapDesc }).onClick(() => {
        if (this.flexWrap == FlexWrap.NoWrap) {
          this.flexWrap = FlexWrap.Wrap
          this.flexWrapDesc = '布局换行FlexWrap.Wrap'
        } else if (this.flexWrap == FlexWrap.Wrap) {
          this.flexWrap = FlexWrap.WrapReverse
          this.flexWrapDesc = '布局换行FlexWrap.WrapReverse'
        } else if (this.flexWrap == FlexWrap.WrapReverse) {
          this.flexWrap = FlexWrap.NoWrap
          this.flexWrapDesc = '布局换行FlexWrap.NoWrap'
        }
      })

      CommonButton1({ text: $justifyContentDesc }).onClick(() => {
        if (this.justifyContent == FlexAlign.Start) {
          this.justifyContent = FlexAlign.Center
          this.justifyContentDesc = '主轴对齐方式FlexAlign.Center'
        } else if (this.justifyContent == FlexAlign.Center) {
          this.justifyContent = FlexAlign.End
          this.justifyContentDesc = '主轴对齐方式FlexAlign.End'
        } else if (this.justifyContent == FlexAlign.End) {
          this.justifyContent = FlexAlign.SpaceBetween
          this.justifyContentDesc = '主轴对齐方式FlexAlign.SpaceBetween'
        } else if (this.justifyContent == FlexAlign.SpaceBetween) {
          this.justifyContent = FlexAlign.SpaceAround
          this.justifyContentDesc = '主轴对齐方式FlexAlign.SpaceAround'
        } else if (this.justifyContent == FlexAlign.SpaceAround) {
          this.justifyContent = FlexAlign.SpaceEvenly
          this.justifyContentDesc = '主轴对齐方式FlexAlign.SpaceEvenly'
        } else if (this.justifyContent == FlexAlign.SpaceEvenly) {
          this.justifyContent = FlexAlign.Start
          this.justifyContentDesc = '主轴对齐方式FlexAlign.Start'
        }
      })

      CommonButton1({ text: $itemAlignDesc }).onClick(() => {
        if (this.itemAlign == ItemAlign.Auto) {
          this.itemAlign = ItemAlign.Start
          this.itemAlignDesc = '交叉轴对齐ItemAlign.Start'
        } else if (this.itemAlign == ItemAlign.Start) {
          this.itemAlign = ItemAlign.Center
          this.itemAlignDesc = '交叉轴对齐ItemAlign.Center'
        } else if (this.itemAlign == ItemAlign.Center) {
          this.itemAlign = ItemAlign.End
          this.itemAlignDesc = '交叉轴对齐ItemAlign.End'
        } else if (this.itemAlign == ItemAlign.End) {
          this.itemAlign = ItemAlign.Baseline
          this.itemAlignDesc = '交叉轴对齐ItemAlign.Baseline'
        } else if (this.itemAlign == ItemAlign.Baseline) {
          this.itemAlign = ItemAlign.Stretch
          this.itemAlignDesc = '交叉轴对齐ItemAlign.Stretch'
        } else if (this.itemAlign == ItemAlign.Stretch) {
          this.itemAlign = ItemAlign.Auto
          this.itemAlignDesc = '交叉轴对齐ItemAlign.Auto'
        }
      })

      Flex({
        direction: this.directionState,
        wrap: this.flexWrap,
        justifyContent: this.justifyContent,
        alignItems: this.itemAlign
      }) {
        Text('1')
          .fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.Red)
          .textAlign(TextAlign.Center)
          .width('35%')
          .height(50)
        Text('2')
          .fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.Green)
          .textAlign(TextAlign.Center)
          .width('35%')
          .height(60)
        Text('3')
          .fontSize(15)
          .fontColor(Color.Black)
          .backgroundColor(Color.Yellow)
          .textAlign(TextAlign.Center)
          .width('35%')
          .height(70)
      }.width('100%')
      .height('60%')
      .padding(10)
      .backgroundColor('#e8e8e8')
    }.width('100%')
  }
}