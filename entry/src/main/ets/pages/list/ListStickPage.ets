import util from '@ohos.util'
import router from '@ohos.router';
import { CommonButton } from '../component/MyComponent';
import thermal from '@ohos.thermal';
import { CircleView } from '../component/TitleComponent';

const alphabets = ['#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
  'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

class Contact {
  key: string = util.generateRandomUUID(true);
  name: string;
  phone: string;

  constructor(name: string, phone: string) {
    this.name = name;
    this.phone = phone;
  }
}

class UserInfo {
  title: string = ''
  contact?: Array<Contact>
}

@Entry
@Component
struct ListStickPage {
  @State currentHeader: string = ''
  @State currentAlphabets: string = ''
  private listData: Array<UserInfo> = [
    {
      title: 'A',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
    {
      title: 'B',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
    {
      title: 'C',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
    {
      title: 'D',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
    {
      title: 'L',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
    {
      title: 'M',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
    {
      title: 'T',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
    {
      title: 'S',
      contact: [
        new Contact('张三1', '17682739473'),
        new Contact('张三2', '56789876567'),
        new Contact('张三3', '23456765433'),
        new Contact('张三4', '45654323454'),
        new Contact('张三5', '23454454545'),
        new Contact('张三6', '655654y6545'),
        new Contact('张三7', '34543455434'),
        new Contact('张三8', '12121232344')
      ]
    },
  ]
  private listScroller: ListScroller = new ListScroller(); //控制List滚动的位置
  @State selectedIndex: number = 0

  @Builder
  itemHeader(text: string) {
    Text(text)
      .fontSize(15)
      .fontColor(Color.Pink)
      .backgroundColor(Color.Gray)
      .width('100%')
      .padding(5)
  }

  build() {
    Column() {

      Stack({ alignContent: Alignment.BottomEnd }) {
        Stack() {
          List({ space: 20, scroller: this.listScroller }) {
            ForEach(this.listData, (item: UserInfo, indexGroup: number) => {
              ListItemGroup({ header: this.itemHeader(item.title) }) {
                ForEach(item.contact, (contact: Contact, index) => {
                  ListItem() {
                    Row() {
                      Badge({
                        count: 3,
                        position: BadgePosition.RightTop,
                        style: { badgeColor: Color.Red, badgeSize: 18 }
                      }) {
                        Image($r('app.media.app_icon'))
                          .width(40)
                          .height(40)
                      }

                      Text(contact.name)
                        .fontColor(Color.Red)
                        .fontSize(20)
                        .margin({ left: 10 })
                      Text(contact.phone)
                        .fontColor(Color.Blue)
                        .fontSize(15)
                        .margin({ left: 10 })
                    }.justifyContent(FlexAlign.Start)
                    .alignItems(VerticalAlign.Center)
                    .width('100%')
                  }.height(50)
                  .width('100%')
                }, (contact: Contact) => contact.key)
              }

            })

          }
          //列表显示方向
          .listDirection(Axis.Vertical)
          //显示列数或者行数
          .lanes(1)
          //scrollBar
          .scrollBar(BarState.Auto)
          //添加粘性标题 搭配ListItemGroup使用
          .sticky(StickyStyle.Header)
          .onScrollIndex((start: number, center: number, end: number) => {
            //start为groupItem的索引
            this.currentHeader = this.listData[start].title
          })
          .width('100%')

          AlphabetIndexer({ arrayValue: alphabets, selected: 0 })
            .selectedColor(Color.Red)
            .selected(this.getAlphabetsIndex())
            .usingPopup(true)
            .selectedBackgroundColor(Color.Yellow)
            .popupBackground(Color.Green)
            .popupColor(Color.Orange)
            .itemSize(20)
            .onSelect((index: number) => {
              //index是字母列表的index
              //获取index对应的字母
              this.currentAlphabets = alphabets[index]
              let selectIndex: number = -1
              //在列表的数据中对应字母，找到对应的索引
              for (let i = 0; i < this.listData.length; i++) {
                if (this.listData[i].title === this.currentAlphabets) {
                  selectIndex = i
                  break
                }
              }
              if (selectIndex > 0) {
                //列表滚动到指定位置
                this.listScroller.scrollToItemInGroup(selectIndex, 0, true, ScrollAlign.START)
              }
            })
        }.width('100%')
        .alignContent(Alignment.End)
        .height('100%')

        Image($r('app.media.img3'))
          .width(50)
          .height(50)
          .borderRadius(26)
          .margin(15)
          .onClick(() => {
            this.listScroller.scrollToIndex(0, true)
          })

      }

    }.height('100%')
    .width('100%')
  }

  getAlphabetsIndex(): number {
    let index = alphabets.indexOf(this.currentHeader)
    if (index != -1) {
      return index
    }
    return 0
  }
}