import { ArrayList, Deque, LinkedList, Queue, Stack } from '@kit.ArkTS'
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils'
import { Person } from './Person'
import { LengthMetrics } from '@kit.ArkUI'
import { LengthUnit } from '@ohos.arkui.node'

@Entry
@Component
struct ArrayListPage {
  @State dataList: ArrayList<Person> = new ArrayList()
  @State dataDeque: Deque<Person> = new Deque()
  @State dataLinkList: LinkedList<Person> = new LinkedList()
  @State dataQueue: Queue<Person> = new Queue()
  @State dataStack: Stack<Person> = new Stack()
  selectedItem: Person = new Person('王五', 20)
  @State dataStr: string = ''

  aboutToAppear(): void {
    this.dataList.add(new Person('张三', 18))
    this.dataList.add(new Person('李四', 19))
    this.dataList.add(this.selectedItem)
    this.getDataContent()
  }

  build() {
    Column({ space: 10 }) {
      Text(this.dataStr).fontColor(Color.Black).fontSize(15)
        .lineSpacing(new LengthMetrics(10, LengthUnit.VP))
      Button('增：add')
        .onClick(() => {
          this.dataList.add(new Person('侯哥', 32))
          this.getDataContent()
        })
      Button('增：insert')
        .onClick(() => {
          this.dataList.insert(new Person('大哥', 34), 1)
          this.getDataContent()
        })
      Button('删：removeByIndex:0')
        .onClick(() => {
          if (this.dataList.length > 0) {
            this.dataList.removeByIndex(0)
            this.getDataContent()
          }
        })
      Button('删：remove')
        .onClick(() => {
          let result: boolean = this.dataList.remove(this.selectedItem)
          ToastUtils.show(result ? '删除成功' : '删除失败')
          this.getDataContent()
        })
      Button('删：removeByRange')
        .onClick(() => {
          this.dataList.removeByRange(0, this.dataList.length - 1)
          this.getDataContent()
        })
      Button('改：dataList[0]=xx')
        .onClick(() => {
          this.dataList[0] = new Person('张哥', 18)
          this.getDataContent()
        })
      Button('查:getIndexOf')
        .onClick(() => {
          let index = this.dataList.getIndexOf(this.selectedItem)
          ToastUtils.show('index:' + index)
        })
      Button('查:getLastIndexOf')
        .onClick(() => {
          let index = this.dataList.getLastIndexOf(this.selectedItem)
          ToastUtils.show('index:' + index)
        })
      Button('容量:getCapacity')
        .onClick(() => {
          let capacity = this.dataList.getCapacity()
          ToastUtils.show('capacity:' + capacity)
        })

    }.width('100%')

  }

  getDataContent() {
    let sb: string = ''
    this.dataList.forEach((value: Person, index: number) => {
      sb += value.name + '--' + value.age + '\n'
    })
    this.dataStr = sb
  }
}