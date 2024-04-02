import router from '@ohos.router'
import { CommonButton } from './component/MyComponent'
import { CommonTitle } from './component/MyComponent'

@Entry
@Component
struct LayoutPage {
  @State message: string = 'Hello World'
  @State toggleDesc: string = '开'
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '线性布局-Column' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/ColumnPage' })
          })
        CommonButton({ text: '线性布局-Row' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/RowPage' })
          })
        //自适应拉伸
        CommonTitle({ title: '自适应拉伸：常用空白填充组件Blank()' })
        Column() {
          Row() {
            Text(this.toggleDesc)
              .fontColor(Color.Green)
              .fontSize(16)
            Blank()
            Toggle({ type: ToggleType.Switch, isOn: true })
              .onChange((isOn: Boolean) => {
                this.toggleDesc = isOn ? '开' : '关'
              })
          }.backgroundColor(Color.White)
          .borderRadius(15)
          .width('100%')
          .padding({ left: 15 })
        }.backgroundColor('#e8e8e8').width('100%').padding(20)
        //自适应缩放
        CommonTitle({ title: '自适应缩放：权重layoutWeight-1:2:3' })
        Row() {
          Column().backgroundColor(Color.Red).layoutWeight(1).height('100%')
          Column().backgroundColor(Color.Yellow).layoutWeight(2).height('100%')
          Column().backgroundColor(Color.Blue).layoutWeight(3).height('100%')
        }.width('100%').height(35)

        CommonButton({ text: '自适应延伸：Scroll组件-垂直' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/ScrollPage',
              params: {
                direction: 1
              } }, router.RouterMode.Single)
          })

        CommonButton({ text: '自适应延伸：Scroll组件-水平' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/ScrollPage',
              params: {
                direction: 2
              } }, router.RouterMode.Single)
          })
        CommonButton({ text: '层叠布局-Stack' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/StackPage' })
          })
        CommonButton({ text: '弹性布局-Flex' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/FlexPage' })
          })
        CommonButton({ text: '相对布局-RelativeContainer' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/RelativeContainerPage' })
          })
        CommonButton({ text: '列表布局-List' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/list/ListPage' })
          })
        CommonButton({ text: '列表布局操作' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/list/ListHandlePage' })
          })
        CommonButton({text:'网格布局Grid'})
          .onClick(()=>{
             router.pushUrl({url:'pages/GridPage'})
          })
        CommonButton({text:'轮播Swiper'})
          .onClick(()=>{
            router.pushUrl({url:'pages/SwiperPage'})
          })


      }.width('100%')
    }.width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Auto)
    .edgeEffect(EdgeEffect.Spring)

  }
}