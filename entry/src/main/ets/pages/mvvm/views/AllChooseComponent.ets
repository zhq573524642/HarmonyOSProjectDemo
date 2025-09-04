import TodoListViewModel from "../viewmodel/TodoListViewModel";

@Component
export struct AllChooseComponent {
  @Link todoListViewModel: TodoListViewModel;

  build() {
    Row() {
      Text('待办事项')
        .fontColor(Color.Black)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Button(this.todoListViewModel.isChoosen ? "取消全选" : "全部选择")
        .type(ButtonType.ROUNDED_RECTANGLE)
        .fontColor(Color.White)
        .backgroundColor(Color.Orange)
        .fontSize(15)
        .onClick(() => {
          this.todoListViewModel.chooseAll()
        })
    }.width('100%')
    .padding(15)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}