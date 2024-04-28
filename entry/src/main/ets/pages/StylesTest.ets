//@Styles 定义组件重用样式
//1.仅支持属性和事件方法
//2.不支持参数传递
//3.定义全局重用样式需要加function关键字
//4.定义组件内的重用样式不需要function关键字，可以通过this.xxx引用并改变组件内的变量的值
@Styles
function commonStyle() {
  .width('100%')
  .height(200)
  .margin(10)
  //...
}
//使用
/**
 *  Text('FancyA')
 *  .commonStyle()
 *  .fontSize(30)
 */