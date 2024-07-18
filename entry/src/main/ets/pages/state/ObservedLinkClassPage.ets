@Entry
@Component
struct ObservedLinkClassPage {
  @State user: User = new User(new Person(1))
  @State teacher: Teacher = new Teacher(new Student(1))

  build() {
    Column({ space: 5 }) {
      Text(`源数据User中Person的Size：${this.user.person.size}`).fontSize(16).fontColor(Color.Black)
        .margin(10)
      Text(`源数据Teacher中Student的Size：${this.teacher.student.size}`).fontSize(16).fontColor(Color.Black)
        .margin(10)
      ViewClassA({ person: this.user.person })
      ViewClassB({ student: this.teacher.student })
      Button('改变User中Person的Size：+10')
        .onClick(() => {
          this.user.person.size += 10
        }).margin(10)
      Button('改变Teacher中Student的Size：+20')
        .onClick(() => {
          this.teacher.student.size += 20
        }).margin(10)
      Button('改变User中Person')
        .onClick(() => {
          this.user.person = new Person(66)
        })
        .margin(10)
      Button('改变User')
        .onClick(() => {
          this.user = new User(new Person(77))
        })
        .margin(10)
      Button('改变Teacher中Student')
        .onClick(() => {
          this.teacher.student = new Student(88)
        })
        .margin(10)
      Button('改变Teacher中')
        .onClick(() => {
          this.teacher = new Teacher(new Student(99))
        })
        .margin(10)
    }
  }
}

@Component
struct ViewClassA {
  @ObjectLink person: Person

  build() {
    Column() {
      Text(`User中Person的Size：${this.person.size}`).fontSize(16).fontColor(Color.Black)
        .margin(10)
      Button('改变User中Person的Size:+5')
        .onClick(() => {
          this.person.size += 5
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(20)
    .borderWidth(5)
    .borderColor(Color.Green)
    .margin(5)
  }
}

@Component
struct ViewClassB {
  @ObjectLink student: Student

  build() {
    Column() {
      Text(`Teacher中Student的Size：${this.student.size}`).fontSize(16).fontColor(Color.Black)
        .margin(10)
      Button('改变Teacher中Student的Size:+6')
        .onClick(() => {
          this.student.size += 6
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(20)
    .borderWidth(5)
    .borderColor(Color.Red)
    .margin(5)
  }
}


let NextId: number = 1

@Observed
class Person {
  id: number
  size: number

  constructor(size: number) {
    this.id = NextId++
    this.size = size
  }
}

@Observed
class User {
  person: Person

  constructor(person: Person) {
    this.person = person
  }
}

@Observed
class Student extends Person {
  size: number

  constructor(size: number) {
    super(size)
    this.size = size
  }
}

@Observed
class Teacher {
  student: Student

  constructor(student: Student) {
    this.student = student
  }
}


