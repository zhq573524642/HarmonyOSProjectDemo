import { RouterUtil } from '@ohos/common';
import TodoListViewModel from '../viewmodel/TodoListViewModel';
import { AllChooseComponent } from '../views/AllChooseComponent'
import { TodoListComponent } from '../views/TodoListComponent';
import { common } from '@kit.AbilityKit';

@Entry({ routeName: 'page_entry' })
@Component
export struct PageEntry {
  @State todoListViewModel: TodoListViewModel = new TodoListViewModel(); // View绑定ViewModel的数据
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;

  static startPage() {
    RouterUtil.pushNamedRoute('page_entry')
  }

  async aboutToAppear() {
    //加载初始数据
    await this.todoListViewModel.loadTasks(this.context)
  }

  build() {
    Column() {
      AllChooseComponent({ todoListViewModel: this.todoListViewModel })
      TodoListComponent({ thingsViewModelArray: this.todoListViewModel.things })
    }.width('100%')
    .height('100%')
  }
}