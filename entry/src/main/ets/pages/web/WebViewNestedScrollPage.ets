import { webview } from '@kit.ArkWeb';
import { PageRouter } from '../../router/PageRouter';
import { router } from '@kit.ArkUI';

@Entry({routeName:PageRouter.PAGE_WEB_NESTED_SCROLL})
@Component
export struct WebViewNestedScrollPage {

  static startPage(){
    router.pushNamedRoute({
      name:PageRouter.PAGE_WEB_NESTED_SCROLL
    },router.RouterMode.Single)
  }
  private scrollerForScroll: Scroller = new Scroller();
  controller: webview.WebviewController = new webview.WebviewController();
  controller2: webview.WebviewController = new webview.WebviewController();
  // NestedScrollMode设置成SELF_ONLY时，Web网页滚动到页面边缘后，不与父组件联动，父组件仍无法滚动。
  @State NestedScrollMode0: NestedScrollMode = NestedScrollMode.SELF_ONLY;
  // NestedScrollMode设置成SELF_FIRST时，Web网页滚动到页面边缘后，父组件继续滚动。
  @State NestedScrollMode1: NestedScrollMode = NestedScrollMode.SELF_FIRST;
  // NestedScrollMode设置为PARENT_FIRST时，父组件先滚动，滚动至边缘后通知Web继续滚动。
  @State NestedScrollMode2: NestedScrollMode = NestedScrollMode.PARENT_FIRST;
  // NestedScrollMode设置为PARALLEL时，父组件与Web同时滚动。
  @State NestedScrollMode3: NestedScrollMode = NestedScrollMode.PARALLEL;

  @State NestedScrollModeF: NestedScrollMode = NestedScrollMode.SELF_FIRST;
  @State NestedScrollModeB: NestedScrollMode = NestedScrollMode.SELF_FIRST;
  // scroll竖向的滚动
  @State ScrollDirection: ScrollDirection = ScrollDirection.Vertical;

  build() {
      Scroll(this.scrollerForScroll) {
        Column({ space: 5 }) {
          Row() {
            Text('切换前滚动模式').fontSize(5)
            Button('SELF_ONLY').onClick((event: ClickEvent) => {
              this.NestedScrollModeF = this.NestedScrollMode0
            }).fontSize(5)
            Button('SELF_FIRST').onClick((event: ClickEvent) => {
              this.NestedScrollModeF = this.NestedScrollMode1
            }).fontSize(5)
            Button('PARENT_FIRST').onClick((event: ClickEvent) => {
              this.NestedScrollModeF = this.NestedScrollMode2
            }).fontSize(5)
            Button('PARALLEL').onClick((event: ClickEvent) => {
              this.NestedScrollModeF = this.NestedScrollMode3
            }).fontSize(5)
          }

          Row() {
            Text('切换后滚动模式').fontSize(5)
            Button('SELF_ONLY').onClick((event: ClickEvent) => {
              this.NestedScrollModeB = this.NestedScrollMode0
            }).fontSize(5)
            Button('SELF_FIRST').onClick((event: ClickEvent) => {
              this.NestedScrollModeB = this.NestedScrollMode1
            }).fontSize(5)
            Button('PARENT_FIRST').onClick((event: ClickEvent) => {
              this.NestedScrollModeB = this.NestedScrollMode2
            }).fontSize(5)
            Button('PARALLEL').onClick((event: ClickEvent) => {
              this.NestedScrollModeB = this.NestedScrollMode3
            }).fontSize(5)
          }

          Text('当前内嵌前滚动模式 scrollForward ---' + `${this.NestedScrollModeF}`).fontSize(10)
          Text('当前内嵌后滚动模式  scrollBackward ---' + `${this.NestedScrollModeB}`).fontSize(10)

          Text("Scroll Area")
            .width("100%")
            .height("10%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)
          Text("Scroll Area")
            .width("100%")
            .height("10%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)
          Text("Scroll Area")
            .width("100%")
            .height("10%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)
          Text("Scroll Area")
            .width("100%")
            .height("10%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)

          Web({ src: $rawfile('TestScrollWebH5.html'), controller: this.controller })
            .nestedScroll({
              scrollForward: this.NestedScrollModeF,
              scrollBackward: this.NestedScrollModeB,
            })
            .width("100%")
            .height('40%')

          Text("Scroll Area")
            .width("100%")
            .height("20%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)
          Text("Scroll Area")
            .width("100%")
            .height("10%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)
          Text("Scroll Area")
            .width("100%")
            .height("10%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)
          Text("Scroll Area")
            .width("100%")
            .height("10%")
            .backgroundColor(0X330000FF)
            .fontSize(16)
            .textAlign(TextAlign.Center)

        }.width("95%").border({ width: 5 })
      }
      .width("100%").height("120%").border({ width: 5 }).scrollable(this.ScrollDirection)
  }
}