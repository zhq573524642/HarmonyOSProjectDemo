import FaultLogger from '@ohos.faultLogger'
import thermal from '@ohos.thermal'

let name: string = '张三'
let age: number = 12
//枚举
enum Color {green, yellow, red, black, white}


let className: string | number
className = '3'
className = 3
//数组
let list1: string[] = ['1', '2', '3']
let list2: number[] = [1, 2, 3]
let list3: Array<number> = [1, 2, 3]
//元组
let x: [string, number, boolean]
x = ['aaa', 12, false] //类型按顺序赋值
//unknow
let noSure: unknown = 1
noSure = 'aaa'
noSure = false
noSure = 123
//null和undefined
let a: null = null
let b: undefined = undefined
//联合类型
let com: string | boolean | number
com = false
com = 1123
com = 'qqq'

function test(): void {

  let color: Color = Color.yellow
  //迭代数组元素 '1','2','3'
  for (let element of list1) {
    console.log(element)
  }
  //迭代数组下表 0,1,2
  for (let list1Key in list1) {
    console.log(list1Key)
  }

  test1("abc", 1, 2, 3, 4)
  test2('zhangsan')
  //调用箭头函数
  arrowFun("abc", 11)
}
//剩余参数 可变参数,只能作为参数列表最后一个参数
function test1(name: string, ...age: number[]) {

}
//可选参数
function test2(name: string, age?: number) {

}
//箭头函数
let arrowFun = (name: string, age: number) => {

}

class Person {
  private name: string
  private age: number

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  public getInfo(className?: string): string {
    return 'my name is ${this.name} and age is ${this.age}'
  }
}