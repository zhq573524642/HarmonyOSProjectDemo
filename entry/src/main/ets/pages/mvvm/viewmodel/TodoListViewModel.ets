import ThingsViewModel from "./ThingsViewModel";
import { common } from "@kit.AbilityKit";
import TodoListModel from "../model/TodoListModel";

@Observed
export class ThingsViewModelArray extends Array<ThingsViewModel> {
}

@Observed
export default class TodoListViewModel {
  @Track isChoosen: boolean = false;
  @Track things: ThingsViewModelArray = new ThingsViewModelArray();

  async loadTasks(context: common.UIAbilityContext) {
    //获取数据
    let todoList = new TodoListModel();
    await todoList.loadTasks(context);
    //将数据添加到数组
    for (let things of todoList.things) {
      let todoListViewModel = new ThingsViewModel();
      todoListViewModel.updateTask(things);
      this.things.push(todoListViewModel);
    }
  }

  chooseAll(): void {
    this.isChoosen = !this.isChoosen;
    for (let things of this.things) {
      things.isFinished = this.isChoosen;
    }
  }
}