
//@Extend装饰器 扩展原生组件样式
//1.@Extend仅支持定义在全局，不支持在组件内部定义，只能在当前文件内使用，不支持export
//2.可以传递参数
//3.参数可以为function，作为Event事件的句柄
//4.@Extend的参数可以为状态变量，当状态变量改变时，UI可以正常的被刷新渲染

// @Extend(Text)可以支持Text的私有属性fontColor
@Extend(Text) function fancy () {
  .fontColor(Color.Red)
}
// superFancyText可以调用预定义的fancy
@Extend(Text) function superFancyText(size:number) {
  .fontSize(size)
  .fancy()
}

@Extend(Text) function makeMeClick(onClick: () => void) {
  .backgroundColor(Color.Blue)
  .onClick(onClick)
}
