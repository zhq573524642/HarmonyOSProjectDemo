import ThingsViewModel from "../viewmodel/ThingsViewModel";
import { ThingsViewModelArray } from "../viewmodel/TodoListViewModel";
import { ThingsComponent } from "./ThingsComponent";

@Component
export struct TodoListComponent {
  @ObjectLink thingsViewModelArray: ThingsViewModelArray;
  build() {
    Column() {
      List({space:10}) {
        ForEach(this.thingsViewModelArray, (item: ThingsViewModel) => {
           ListItem(){
              ThingsComponent({thingsViewModel:item})
           }.width('90%')
          .backgroundColor(Color.Pink)
          .borderRadius(10)
        }, (item: ThingsViewModel) => {
          return item.thingsName;
        })
      }.width('100%')
      .alignListItem(ListItemAlign.Center)
    }
  }
}