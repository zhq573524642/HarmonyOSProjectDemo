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
struct ListPage {
  @State message: string = 'Hello World'
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
    }
  ]
  @State listDirection: Axis = Axis.Vertical
  @State lane: number = 1
  private listScroller: Scroller = new Scroller(); //控制List滚动的位置
  @State selectedIndex: number = 0
  private availableThings: string[] = ['读书', '运动', '旅游', '听音乐', '看电影', '唱歌'];

  @Builder
  itemHeader(text: string) {
    Text(text)
      .fontSize(15)
      .fontColor(Color.Pink)
      .backgroundColor(Color.Gray)
      .width('100%')
      .padding(5)
  }

  @Builder
  itemEnd(index: number) {
    Button({ type: ButtonType.Normal }) {
      Text('删除').fontColor(Color.White)
    }.height(50)
    .width(60)
    .backgroundColor(Color.Red)
    .onClick(() => {

    })
  }

  build() {
    Column() {
      CommonButton({ text: 'listDirection' })
        .onClick(() => {
          if (this.listDirection == Axis.Vertical) {
            this.listDirection = Axis.Horizontal
          } else {
            this.listDirection = Axis.Vertical
          }
        })
      CommonButton({ text: '显示行数或列数lane' })
        .onClick(() => {
          this.lane = this.lane + 1
          if (this.lane > 3) {
            this.lane = 1
          }
        })
      CommonButton({ text: '滚动到顶部' })
        .onClick(() => {
          this.listScroller.scrollToIndex(0)
        })
      CommonButton({ text: '新增条目' })
        .onClick(() => {
          TextPickerDialog.show({
            range: this.availableThings,
            onAccept: (value: TextPickerResult) => {
              // this.listData
            }
          })
        })
      Stack() {
        List({ space: 20, scroller: this.listScroller }) {
          ForEach(this.listData, (item: UserInfo) => {
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
                }.height(50)
                .width('100%')
                .swipeAction({ end: this.itemEnd(index) })
              }, (contact: Contact) => contact.key)
            }.divider({
              strokeWidth: 1, color: Color.Brown, startMargin: 20, endMargin: 20
            })

          })

        }
        //列表显示方向
        .listDirection(this.listDirection)
        //条目分割线
        .divider({ strokeWidth: 2, color: Color.Orange, startMargin: 15, endMargin: 15 })
        //显示列数或者行数
        .lanes(this.lane)
        //scrollBar
        .scrollBar(BarState.Auto)
        //添加粘性标题 搭配ListItemGroup使用
        .sticky(StickyStyle.Header)
        .onScrollIndex((firstIndex: number) => {
          this.selectedIndex = firstIndex
        })
        .width('100%')

        AlphabetIndexer({ arrayValue: alphabets, selected: 0 })
          .selectedColor(Color.Red)
          .selected(this.selectedIndex)
          .usingPopup(true)
          .selectedBackgroundColor(Color.Yellow)
          .popupBackground(Color.Green)
          .popupColor(Color.Orange)
          .itemSize(20)
      }.width('100%')
      .alignContent(Alignment.End)
      .height('100%')

    }.height('100%')
    .width('100%')
  }
}