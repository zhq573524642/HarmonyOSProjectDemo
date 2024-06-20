import util from '@ohos.util';

export class Person {
  key: string = util.generateRandomUUID(true)
  name: string;
  sex: string;
  phone: string;
  itemHeight: Length = 0
  isSelect: boolean = false

  constructor(name: string, sex: string, phone: string) {
    this.name = name;
    this.sex = sex;
    this.phone = phone;
  }
}