import { Person } from '../data/Person'
import { curves, promptAction } from '@kit.ArkUI'
import { NavDialogPage } from './NavDialogPage'
import { NavStandardPage } from './NavStandardPage'
import { BusinessError } from '@kit.BasicServicesKit'
import { CustomToggle } from '../../widget/CustomToggle'


let NextID: number = 1

class OnePerson {
  constructor(name: string, age: number) {
    this.id = NextID++
    this.name = name
    this.age = age
  }

  id: number = 0
  name: string = ''
  age: number = 0
  isSelected: boolean = false
}

@Entry
@Component
struct NavigationTestPage {
  private toolbarItem1: ToolbarItem = {
    value: '首页', icon: 'resources/base/media/tab_home_t.png', action: () => {

    }
  }
  private toolbarItem2: ToolbarItem = {
    value: '发现', icon: 'resources/base/media/tab_find_t.png', action: () => {
    }
  }
  private toolbarItem3: ToolbarItem = {
    value: '我的', icon: 'resources/base/media/tab_my_t.png', action: () => {
    }
  }
  @State navigationMode: NavigationMode = NavigationMode.Auto
  @State titleMode: NavigationTitleMode = NavigationTitleMode.Free
  dataList: Array<OnePerson> = [
    new OnePerson('DialogNavigation', 18),
    new OnePerson('PageNavigation', 19),
    new OnePerson('自定义转场动画', 20),
    new OnePerson('共享元素转场动画', 20),
    new OnePerson('系统路由表跳转Har包中页面', 20)
  ]
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()
  private scroller: Scroller = new Scroller()
  @State pageSwitch: number = 0
  @State isHideTitleBar: boolean = false
  @State isHideToolBar: boolean = false

  @Builder
  PageMap(name: string) {
    if (name == 'NavDialogPage') {
      NavDialogPage()
    } else if (name == 'NavStandardPage') {
      NavStandardPage()
    }
  }

  build() {
    Navigation(this.pageStack) {
      Scroll(this.scroller) {
        Column({ space: 10 }) {
          Row() {
            Text('NavMode:')
            Button('Auto')
              .onClick(() => {
                this.navigationMode = NavigationMode.Auto
              })
            Button('Stack')
              .onClick(() => {
                this.navigationMode = NavigationMode.Stack
              })
            Button('Split')
              .onClick(() => {
                this.navigationMode = NavigationMode.Split
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

          Row() {
            Text('TitleMode:')
            Button('Free')
              .onClick(() => {
                this.titleMode = NavigationTitleMode.Free
              })
            Button('Mini')
              .onClick(() => {
                this.titleMode = NavigationTitleMode.Mini
              })
            Button('Full')
              .onClick(() => {
                this.titleMode = NavigationTitleMode.Full
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

          Row() {
            CustomToggle({
              text: 'hideTitleBar',
              isOpen: this.isHideTitleBar
            })
            CustomToggle({
              text: 'hideToolBar',
              isOpen: this.isHideToolBar
            })
          }.width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .margin({ top: 10 })
        .width('100%')
      }.width('100%')


      List({ space: 15, scroller: this.scroller }) {
        ForEach(this.dataList, (item: OnePerson, index: number) => {
          ListItem() {
            NavRouter() {
              Text(item.name)
                .fontColor(Color.Black)
                .fontSize(20)
                .width('100%')
                .height(60)
                .textAlign(TextAlign.Center)
                .borderRadius(20)
                .borderColor(Color.Gray)
                .borderWidth(1)
                .backgroundColor(Color.White)
                .onClick(() => {
                  switch (index) {
                    case 0:
                      this.pageStack.pushPathByName('NavDialogPage', {
                        name: '张三',
                        age: 18
                      }, (info: PopInfo) => {
                        console.debug('===PopInfo：' + info.info.name + '==' + JSON.stringify(info.result))
                      }, true)
                      break
                    case 1:
                      this.handlePush()
                      break
                    case 2:

                      break
                    case 3:
                      animateTo({ duration: 1000, curve: curves.springMotion() }, () => {
                        this.pageStack.pushPath({ name: 'NavStandardPage' }, false)
                      })
                      break
                    case 4:
                      this.pageStack.pushPathByName('NavHarPage', '', false)
                      break
                  }
                })
              // NavDestination() {
              //   Text("NavDestinationContent" + item.name)
              // }
              // .title("NavDestinationTitle" + item.name)
            }
          }.geometryTransition('shareId1')
        }, (item: Person) => item.id.toString())
      }.width('80%')
      .margin({ top: 12 })
    }
    .title('主页', {
      //标题栏
      backgroundColor: Color.Pink,
      barStyle: BarStyle.STANDARD
    })
    .hideTitleBar(this.isHideTitleBar) //是否隐藏标题栏
    .hideToolBar(this.isHideToolBar) //是否隐藏ToolBar
    .mode(this.navigationMode)
    .titleMode(this.titleMode)
    .navDestination(this.PageMap)
    .menus([
      {
        value: "菜单1", icon: "resources/base/media/tab_home_f.png", action: () => {

      }
      },
      {
        value: "菜单2", icon: "resources/base/media/tab_find_f.png", action: () => {
      }
      },
      {
        value: "菜单3", icon: "resources/base/media/tab_info_f.png", action: () => {
      }
      },
      {
        value: "菜单4", icon: "resources/base/media/tab_my_f.png", action: () => {
      }
      }
    ])
    .toolbarConfiguration([this.toolbarItem1, this.toolbarItem2, this.toolbarItem3])
  }

  handlePush() {
    TextPickerDialog.show({
      range: ['pushPath', 'pushPathByName', 'pushPathByName/onPop', 'pushDestination',
        'pushDestinationByName/ErrorCode'],
      selected: 0,
      canLoop: false,
      onAccept: (value: TextPickerResult) => {
        switch (value.index) {
          case 0:
            this.pageStack.pushPath({
              name: 'NavStandardPage', param: 'aaaaaa',
            })
            break
          case 1:
            this.pageStack.pushPathByName('NavStandardPage', 'bbbbbb')
            break
          case 2:
            this.pageStack.pushPathByName('NavStandardPage',
              {
                name: '王五',
                age: 22
              }, (popInfo: PopInfo) => {
                console.debug('===onPop：' + JSON.stringify(popInfo))
              })
            break
          case 3:
            this.pageStack.pushDestination({
              name: 'NavStandardPage', param: new Object({
                name: '钱七',
                age: 23
              })
            })
            break
          case 4:
            this.pageStack.pushDestinationByName('NavStandardPage', new Object({
              name: '李六',
              age: 24
            }))
              .catch((error: BusinessError) => {
                console.debug('===Error:' + JSON.stringify(error))
              })
              .then(() => {
                console.debug('===Push destination succeed.');
              })
            break
        }
      },
      onCancel: () => {

      }
    })
  }
}

