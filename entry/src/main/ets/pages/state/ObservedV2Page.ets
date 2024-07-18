@Entry
@Component
struct ObservedV2Page {
  student: StudentClass = new StudentClass()
  teacher: TeacherClass = new TeacherClass()

  build() {
    Column({ space: 10 }) {
      Text(`老师-teacherName：${this.teacher.teacherName}`).fontSize(15).fontSize(Color.Black)
      Text(`老师-name(父类)：${this.teacher.name}`).fontSize(15).fontSize(Color.Black)
      Text(`老师-studentName：${this.teacher.student.studentName}`).fontSize(15).fontSize(Color.Black)
      Text(`老师-studentName/name(父类)：${this.teacher.student.name}`).fontSize(15).fontSize(Color.Black)
      Text(`老师-age：${this.teacher.age}`).fontSize(15).fontSize(Color.Black)
      Button('改变老师-teacherName')
        .onClick(() => {
          this.teacher.teacherName = '孙老师'
        })
      Button('改变老师-name(父类)')
        .onClick(() => {
          this.teacher.name = '老师人'
        })
      Button('改变老师-studentName')
        .onClick(() => {
          this.teacher.student.studentName = '孟同学'
        })
      Button('改变老师-studentName/name(父类)')
        .onClick(() => {
          this.teacher.student.name = '同学人A'
        })
      Button('改变老师-age(不会刷新UI)')
        .onClick(() => {
          this.teacher.age += 1
        })
      Text(`学生-teacherName：${this.student.studentName}`).fontSize(15).fontSize(Color.Black)
      Text(`学生-name(父类)：${this.student.name}`).fontSize(15).fontSize(Color.Black)
      Text(`学生-age(不会刷新UI)：${this.student.age}`).fontSize(15).fontSize(Color.Black)

      Button('改变学生-teacherName')
        .onClick(() => {
          this.student.studentName = '刘同学'
        })
      Button('改变学生-name(父类)')
        .onClick(() => {
          this.student.name = '同学人B'
        })
      Button('改变学生-age(不会刷新UI)')
        .onClick(() => {
          this.student.age += 1
        })
    }
    .width('100%')
  }
}

@ObservedV2
class PersonClass {
  @Trace name: string = '人'
}

@ObservedV2
class StudentClass extends PersonClass {
  @Trace studentName: string = '张同学'
  age: number = 0
}

@ObservedV2
class TeacherClass extends PersonClass {
  @Trace student: StudentClass = new StudentClass()
  @Trace teacherName: string = '王老师'
  age: number = 0
}