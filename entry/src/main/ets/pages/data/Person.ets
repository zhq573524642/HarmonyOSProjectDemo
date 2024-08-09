
export class Person {
  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  id: number = 0
  name: string = ''
  age: number = 0
  isSelected: boolean = false
}