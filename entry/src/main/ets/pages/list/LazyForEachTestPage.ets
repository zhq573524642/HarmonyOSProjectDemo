import { RouterUtil } from "@ohos/common";
import { router } from "@kit.ArkUI";
import LazyDataSource from "../../utils/LazyDataSource";
import mViewModel from "./MyViewModel";


export enum LazyForEachTypeEnum {
  ADD_ONE = 1,
  ADD_MULTI,
  DELETE_ONE,
  DELETE_MULTI,
  UPDATE_ONE,
  UPDATE_MULTI,
  UPDATE_INNER_ONE
}

@Observed
export class MyBook {
  name: string = ''
  id: string = ''
   isSelected: boolean = false
  tag: Tag = new Tag()
}

@Observed
export class Tag {
  name: string = ''
  isCollected: boolean = false
}

@Entry({
  routeName: 'LazyForEachTestPage'
})
@Component
export struct LazyForEachTestPage {
  static startPage(type: LazyForEachTypeEnum) {
    RouterUtil.pushNamedRoute('LazyForEachTestPage', {
      "fromType": type
    })
  }

  type: LazyForEachTypeEnum = LazyForEachTypeEnum.ADD_ONE
  dataList: LazyDataSource<MyBook> = new LazyDataSource()
  scroller: Scroller = new Scroller()

  aboutToAppear(): void {
    const param = router.getParams() as Record<string, Object>
    if (param) {
      this.type = param.type as LazyForEachTypeEnum
    }

    this.dataList.pushArrayData(mViewModel.getBookInitData())

  }

  build() {
    Column() {
      Button(this.type + '')
        .onClick(() => {
          switch (this.type) {
            case LazyForEachTypeEnum.ADD_ONE:
              break
          }
        })
      List({ scroller: this.scroller, space: 12 }) {
        LazyForEach(this.dataList, (item: MyBook, index: number) => {
          ListItem() {
            Row({ space: 10 }) {
              Text(item.name).fontSize(16).fontColor(item.isSelected ? Color.Red : Color.Black)
              Text(`标签：${item.tag.name}`).fontSize(12).fontColor(item.isSelected ? Color.Red : Color.Gray)
              Blank().layoutWeight(1)
              Image(item.tag.isCollected ? $r('app.media.ic_collect_select') : $r('app.media.ic_collect_unselect'))
                .width(30)
                .height(30)
                .onClick(() => {
                  item.tag.isCollected = !item.tag.isCollected
                  this.dataList.notifyDataChange(index)
                })
            }.width('100%')
            .padding({
              left: 20,
              right: 20,
              top: 15,
              bottom: 15
            })
            .backgroundColor(Color.White)
            .onClick(() => {
              let  updateItem=new MyBook()
              updateItem.name=item.name
              updateItem.isSelected=!item.isSelected
              this.dataList.changeData(index, updateItem)
            })

          }
          .padding({ left: 15, right: 15 })
        }, (item: MyBook) => item.id)
      }.width('100%')
      .layoutWeight(1)
      .cachedCount(2)
    }.backgroundColor('#eeeeee')
  }
}
