let nextId = 0;

@Observed
export class ObservedArray<T> extends Array<T> {
  constructor(args: T[]) {
    console.log(`ObservedArray: ${JSON.stringify(args)} `)
    if (args instanceof Array) {
      super(...args);
    } else {
      super(args)
    }
  }
}

@Observed
export class Address {
  street: string;
  zip: number;
  city: string;

  constructor(street: string,
              zip: number,
              city: string) {
    this.street = street;
    this.zip = zip;
    this.city = city;
  }
}

@Observed
export class Person {
  id_: string;
  name: string;
  address: Address;
  phones: ObservedArray<string>;

  constructor(name: string,
              street: string,
              zip: number,
              city: string,
              phones: string[]) {
    this.id_ = `${nextId}`;
    nextId++;
    this.name = name;
    this.address = new Address(street, zip, city);
    this.phones = new ObservedArray<string>(phones);
  }
}

export class AddressBook {
  me: Person;
  contacts: ObservedArray<Person>;

  constructor(me: Person, contacts: Person[]) {
    this.me = me;
    this.contacts = new ObservedArray<Person>(contacts);
  }
}

// 渲染出Person对象的名称和Observed数组<string>中的第一个号码
// 为了更新电话号码，这里需要@ObjectLink person和@ObjectLink phones，
// 不能使用this.person.phones，内部数组的更改不会被观察到。
// 在AddressBookView、PersonEditView中的onClick更新selectedPerson
@Component
struct PersonView {
  @ObjectLink person: Person;
  @ObjectLink phones: ObservedArray<string>;
  @Link selectedPerson: Person;

  build() {
    Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceBetween, alignContent: FlexAlign.Center }) {
      Text(this.person.name).fontSize(18).fontColor(Color.Red)
      if (this.phones.length) {
        Text(this.phones[0])
      }
    }

    .height(55)
    .backgroundColor(this.selectedPerson.name == this.person.name ? Color.Orange : "#ffffff")
    .onClick(() => {
      this.selectedPerson = this.person;
    })
  }
}

@Component
struct phonesNumber {
  @ObjectLink phoneNumber: ObservedArray<string>

  build() {
    Column() {

      ForEach(this.phoneNumber,
        (phone: ResourceStr, index?: number) => {
          TextInput({ text: phone })
            .width(150)
            .margin(10)
            .onChange((value) => {
              console.log(`${index}. ${value} value has changed`)
              this.phoneNumber[index!] = value;
            })
        },
        (phone: ResourceStr, index: number) => `${this.phoneNumber[index] + index}`
      )
    }
  }
}


// 渲染Person的详细信息
// @Prop装饰的变量从父组件AddressBookView深拷贝数据，将变化保留在本地, TextInput的变化只会在本地副本上进行修改。
// 点击 "Save Changes" 会将所有数据的复制通过@Prop到@Link, 同步到其他组件
@Component
struct PersonEditView {
  @Consume addrBook: AddressBook;
  /* 指向父组件selectedPerson的引用 */
  @Link selectedPerson: Person;
  /*在本地副本上编辑，直到点击保存*/
  @Prop name: string = "";
  @Prop address: Address = new Address("", 0, "");
  @Prop phones: ObservedArray<string> = [];

  selectedPersonIndex(): number {
    return this.addrBook.contacts.findIndex((person: Person) => person.id_ == this.selectedPerson.id_);
  }

  build() {
    Column() {
      TextInput({ text: this.name })
        .onChange((value) => {
          this.name = value;
        }).margin({ left: 20, right: 20, top: 10 })
      TextInput({ text: this.address.street })
        .onChange((value) => {
          this.address.street = value;
        }).margin({ left: 20, right: 20, top: 10 })

      TextInput({ text: this.address.city })
        .onChange((value) => {
          this.address.city = value;
        }).margin({ left: 20, right: 20, top: 10 })

      TextInput({ text: this.address.zip.toString() })
        .onChange((value) => {
          const result = Number.parseInt(value);
          this.address.zip = Number.isNaN(result) ? 0 : result;
        }).margin({ left: 20, right: 20, top: 10 })

      if (this.phones.length > 0) {
        phonesNumber({ phoneNumber: this.phones })
      }

      Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.SpaceAround }) {
        Text("Save Changes")
          .onClick(() => {
            // 将本地副本更新的值赋值给指向父组件selectedPerson的引用
            // 避免创建新对象，在现有属性上进行修改
            this.selectedPerson.name = this.name;
            this.selectedPerson.address = new Address(this.address.street, this.address.zip, this.address.city)
            this.phones.forEach((phone: string, index: number) => {
              this.selectedPerson.phones[index] = phone
            });
          }).backgroundColor(Color.Green)
          .padding(10)
          .margin(10)
        if (this.selectedPersonIndex() != -1) {
          Text("Delete Contact")
            .backgroundColor(Color.Red)
            .padding(10)
            .margin(10)
            .onClick(() => {
              let index = this.selectedPersonIndex();
              console.log(`delete contact at index ${index}`);

              // 删除当前联系人
              this.addrBook.contacts.splice(index, 1);

              // 删除当前selectedPerson，选中态前移一位
              index = (index < this.addrBook.contacts.length) ? index : index - 1;

              // 如果contract被删除完，则设置me为选中态
              this.selectedPerson = (index >= 0) ? this.addrBook.contacts[index] : this.addrBook.me;
            })
        }
      }

    }
  }
}

@Component
struct AddressBookView {
  @ObjectLink me: Person;
  @ObjectLink contacts: ObservedArray<Person>;
  @State selectedPerson: Person = new Person("", "", 0, "", []);

  aboutToAppear() {
    this.selectedPerson = this.me;
  }

  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Start }) {
      Text("Me:").height(30)
        .textAlign(TextAlign.Center).fontSize(20).fontWeight(FontWeight.Bold)
      PersonView({
        person: this.me,
        phones: this.me.phones,
        selectedPerson: this.selectedPerson
      })

      Divider().height(8)

      ForEach(this.contacts, (contact: Person) => {
        PersonView({
          person: contact,
          phones: contact.phones as ObservedArray<string>,
          selectedPerson: this.selectedPerson
        })
      },
        (contact: Person): string => {
          return contact.id_;
        }
      )

      Divider().height(8)

      Text("Edit:")
        .height(30)
        .textAlign(TextAlign.Center).fontSize(20).fontWeight(FontWeight.Bold)
      PersonEditView({
        selectedPerson: this.selectedPerson,
        name: this.selectedPerson.name,
        address: this.selectedPerson.address,
        phones: this.selectedPerson.phones
      })
    }
    .borderStyle(BorderStyle.Solid).borderWidth(5).borderColor(0xAFEEEE).borderRadius(5)
  }
}

@Entry
@Component
struct PageEntry {
  @Provide addrBook: AddressBook = new AddressBook(
    new Person("强哥", "王四营街道", 180, "北京", ["17610676602", "13427503913", "15735926602"]),
    [
      new Person("用户1", "广渠街道", 180, "天津", ["16762876992", "13782768902"]),
      new Person("用户2", "科创十街", 180, "阳泉", ["13609876574", "15873934844"]),
      new Person("用户3", "科创九街", 180, "上海", ["18928278374", "16838378383"]),
    ]);

  build() {
    Column() {
      AddressBookView({
        me: this.addrBook.me,
        contacts: this.addrBook.contacts,
        selectedPerson: this.addrBook.me
      })
    }
  }
}