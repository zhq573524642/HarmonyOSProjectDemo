import { RouterUtil } from "@ohos/common";
import { router } from "@kit.ArkUI";
import LazyDataSource from "../../utils/LazyDataSource";
import mViewModel from "./MyViewModel";


export enum LazyForEachTypeEnum {
  ADD_ONE = 1,
  ADD_ONE_FIRST,
  ADD_MULTI,
  DELETE_ONE,
  DELETE_MULTI,
  UPDATE_ONE,
  EXCHANGE,
  CLEAR
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
      this.type = param.fromType as LazyForEachTypeEnum

    }
    this.dataList.pushArrayData(mViewModel.getBookInitData())

  }

  getABook(): MyBook {
    let book = new MyBook()
    book.id = `${this.dataList.totalCount() + 1}`
    book.name = `书的名称-${book.id}`
    let tag = new Tag()
    tag.name = `小说-${book.id}`
    book.tag = tag
    return book
  }

  build() {
    Column() {
      Button(this.type + '')
        .onClick(() => {
          switch (this.type) {
            case LazyForEachTypeEnum.ADD_ONE:
              //尾部增加一条数据
              this.dataList.pushData(this.getABook())
              break
            case LazyForEachTypeEnum.ADD_ONE_FIRST:
              this.dataList.addData(0, this.getABook())
              break
            case LazyForEachTypeEnum.ADD_MULTI:
              //尾部增加两条数据
              this.dataList.appendArrayData([this.getABook(), this.getABook()])
              break
            case LazyForEachTypeEnum.DELETE_ONE:
              //删除最后一条数据
              this.dataList.deleteData(this.dataList.totalCount() - 1)
              break
            case LazyForEachTypeEnum.DELETE_MULTI:
              //从0开始删除2条数据
              this.dataList.deleteMoreData(0, 2)
              break
            case LazyForEachTypeEnum.UPDATE_ONE:
              //修改第一条数据
              this.dataList.changeData(0, this.getABook())
              break
            case LazyForEachTypeEnum.EXCHANGE:
              //第一条和最后一条数据交换
              this.dataList.moveData(0, this.dataList.totalCount() - 1)
              break
            case LazyForEachTypeEnum.CLEAR:
              this.dataList.clear()
              break
          }
        })
      List({ scroller: this.scroller, space: 12 }) {
        LazyForEach(this.dataList, (item: MyBook, index: number) => {
          ListItem() {

            ChildItem({
              item: item, onItemClick: (book: MyBook) => {
                this.dataList.changeData(index, book)
              }
            })
          }
          .padding({ left: 15, right: 15 })
        }, (item: MyBook) => item.id)
          .onMove((from: number, to: number) => {
            this.dataList.moveDataWithoutNotify(from, to)
          })
      }.width('100%')
      .layoutWeight(1)
      .cachedCount(2)
    }.backgroundColor('#eeeeee')
  }
}

@Component
struct ChildItem {
  @ObjectLink item: MyBook
  onItemClick?: (book: MyBook) => void

  build() {
    Row({ space: 10 }) {
      Text(this.item.name).fontSize(16).fontColor(this.item.isSelected ? Color.Red : Color.Black)
      Text(`标签：${this.item.tag.name}`).fontSize(12).fontColor(this.item.isSelected ? Color.Red : Color.Gray)
      Blank().layoutWeight(1)
      Image(this.item.tag.isCollected ? $r('app.media.ic_collect_select') : $r('app.media.ic_collect_unselect'))
        .width(30)
        .height(30)

    }.width('100%')
    .padding({
      left: 20,
      right: 20,
      top: 15,
      bottom: 15
    })
    .backgroundColor(Color.White)
    .onClick(() => {
      if (this.onItemClick) {
        let updateItem = new MyBook()
        updateItem.id = `${2 * Number.parseInt(this.item.id)}`
        updateItem.name = this.item.name
        updateItem.isSelected = !this.item.isSelected
        updateItem.tag = this.item.tag
        updateItem.tag.isCollected = !this.item.tag.isCollected
        this.onItemClick(updateItem)
      }
    })
  }
}
