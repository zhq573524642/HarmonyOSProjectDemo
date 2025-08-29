import { ArrayList, Deque, LinkedList, Queue, Stack } from '@kit.ArkTS'
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils'
import { Person } from './Person'
import { LengthMetrics } from '@kit.ArkUI'
import { LengthUnit } from '@ohos.arkui.node'
import { CommonTitle } from '../component/MyComponent'
import { RouterUtil } from '@ohos/common'

@Entry({ routeName: 'ArrayListPage' })
@Component
export struct ArrayListPage {
  @State dataList: ArrayList<Person> = new ArrayList()
  @State dataDeque: Deque<Person> = new Deque()
  @State dataLinkList: LinkedList<Person> = new LinkedList()
  @State dataQueue: Queue<Person> = new Queue()
  @State dataStack: Stack<Person> = new Stack()
  selectedItem: Person = new Person('王五', 20)
  @State dataStr: string = ''

  //优势：需要频繁读取集合元素
  //存储位置为连续的内存空间，初始容量为10，支持动态扩容，每次扩容为原始容量的1.5倍。
  //add(element:T):boolean  尾部增加元素,是否插入成功
  //insert(element:T,index:number):void 指定位置(范围不越界)增加元素
  //has(element: T): boolean 判断是否存在指定元素
  //getIndexOf(element: T): number 返回指定元素第一次出现的下标  失败返回-1
  //getLastIndexOf(element: T): number  返回指定元素最后一次出现的下标  失败返回-1
  //arrList[index] 访问指定位置的元素
  //arrList[index]=xxx 修改元素
  //removeByIndex(index: number): T 根据元素的下标值查找元素，返回元素后将其删除
  //remove(element: T): boolean 删除查找到的第一个元素
  //removeByRange(fromIndex: number, toIndex: number): void 删除指定范围的元素，左闭右开，不包含toIndex
  //replaceAllElement((value:T,index:number):T=>{// 根据需要修改指定index的value并返回 return t })
  //sort(comparator?: (firstValue: T, secondValue: T) => number): void
  //subArrayList(fromIndex: number, toIndex: number): ArrayList<T> 截取范围内的元素，返回截取的数组，左闭右开
  //clear():void 清除ArrayList中的所有元素，并把length置为0。
  //clone(): ArrayList<T>  克隆一个与ArrayList相同的实例，并返回克隆后的实例。修改克隆后的实例并不会影响原实例。
  //getCapacity(): number 获取当前实例的容量大小
  //convertToArray(): Array<T> 把当前ArrayList实例转换成数组，并返回转换后的数组
  //isEmpty(): boolean  判断该ArrayList是否为空。
  //increaseCapacityTo(newCapacity: number): void  如果传入的新容量大于或等于ArrayList中的元素个数，将容量变更为新容量。
  //trimToCurrentLength(): void  释放ArrayList中预留的空间，把容量调整为当前的元素个数
  static startPage() {
    RouterUtil.pushNamedRoute('ArrayListPage')
  }

  aboutToAppear(): void {
    this.dataList.add(new Person('张三', 18))
    this.dataList.add(new Person('李四', 19))
    this.dataList.add(this.selectedItem)
    this.getDataContent()
  }

  build() {
    Column({ space: 10 }) {
      CommonTitle({ title: 'ArrayList' })
      Text(this.dataStr).fontColor(Color.Black).fontSize(15)
        .lineSpacing(new LengthMetrics(10, LengthUnit.VP))
      Flex({
        direction: FlexDirection.Row,
        wrap: FlexWrap.Wrap,
        space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) }
      }) {
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
        Button('设置新容量:increaseCapacityTo')
          .onClick(() => {
            this.dataList.increaseCapacityTo(20)
          })
        Button('移除多余容量为元素数量:trimToCurrentLength')
          .onClick(() => {
            this.dataList.trimToCurrentLength()
          })
        Button('replaceAllElements')
          .onClick(() => {
            this.dataList.replaceAllElements((value: Person, index: number): Person => {
              if (index == 0) {
                value.age = 666
              }
              return value
            })
            this.getDataContent()
          })

        Button('排序sort：s-e升序，e-s降序')
          .onClick(() => {
            this.dataList.sort((s: Person, e: Person): number => {
              return e.age - s.age
            })
            this.getDataContent()
          })

        Button('subArrayList截取范围内元素，左闭右开')
          .onClick(()=>{
            let subList=  this.dataList.subArrayList(0,2)
          })
      }

    }.width('100%')

  }

  getDataContent() {
    let sb: string = ''
    //迭代1
    this.dataList.forEach((value: Person, index: number) => {
      sb += value.name + '--' + value.age + '\n'
    })
    //迭代2
    // for (let value of  this.dataList) {
    //   console.info("value:", value);
    // }
    //迭代3
    // let iter = this.dataList[Symbol.iterator]();
    // let temp: IteratorResult<Person> = iter.next();
    // while(!temp.done) {
    //   console.info("value:", temp.value);
    //   temp = iter.next();
    // }

    this.dataStr = sb
  }
}