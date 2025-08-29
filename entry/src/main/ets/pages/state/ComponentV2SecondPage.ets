import { StudentClass } from "./ComponentV2Page"
import { AppStorageV2, PersistenceV2 } from "@kit.ArkUI"
import { RouterUtil } from "@ohos/common"

@Entry({ routeName: 'ComponentV2SecondPage' })
@ComponentV2
export struct ComponentV2SecondPage {
  static startPage() {
    RouterUtil.pushNamedRoute('ComponentV2SecondPage')
  }

  @Local appStorageV2Value1: StudentClass
    = AppStorageV2.connect(StudentClass, 'student1', () => new StudentClass())!
  @Local appStorageV2Value2: StudentClass
    = AppStorageV2.connect(StudentClass, 'student2', () => new StudentClass())!
  @Local persistenceV2Value: StudentClass =
    PersistenceV2.connect(StudentClass, 'p_student', () => new StudentClass())!

  build() {
    Column({ space: 10 }) {
      Button('AppStorageV2:修改key为student1中age的值')
        .onClick(() => {
          this.appStorageV2Value1.age += 5
        })
      Button('AppStorageV2:移除key为student1')
        .onClick(() => {
          AppStorageV2.remove('student1')
        })
      Button('AppStorageV2:修改key为student2中age的值')
        .onClick(() => {
          this.appStorageV2Value2.age += 10
        })
      Button('AppStorageV2:移除key为student2')
        .onClick(() => {
          AppStorageV2.remove('student2')
        })

      Button('PersistenceV2:修改key为p_student中person.age的值')
        .onClick(() => {
          this.persistenceV2Value.person.age += 10
        })
      Button('PersistenceV2:移除key为p_student')
        .onClick(() => {
          PersistenceV2.remove('p_student')
        })
    }.width('100%')
    .width('100%')
  }
}