import util from '@ohos.util';

export class Person {
  key: string = util.generateRandomUUID(true)
   name: string;
   phone: string;

  constructor(name: string, phone: string) {
    this.name = name;
    this.phone = phone;
  }
}