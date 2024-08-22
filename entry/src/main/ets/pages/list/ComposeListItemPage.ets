import { ComposeListItem, IconType } from '@ohos.arkui.advanced.ComposeListItem'
import { ToastUtils } from '@ohos/common/src/main/ets/utils/ToastUtils'

@Entry
@Component
struct ComposeListItemPage {
  leftIconSrc: ResourceStr = $r('app.media.img3')
  @State rightSwitch:boolean=false
  @State rightCheckbox:boolean=false
  @State rightRadio:boolean=false
  @State leftIconType: number = 1
  selectLeftIconTypeList: string[] = ['BADGE(8dp)', 'NORMAL_ICON(小图标16dp)', 'SYSTEM_ICON(系统图标24dp)',
    'HEAD_SCULPTURE(头像40dp)', 'APP_ICON(应用图标64dp)', 'PREVIEW(预览图96dp)', 'LONGITUDINAL(横向 最长96dp)',
    'VERTICAL(竖向 最长96dp)']

  build() {
    Column({ space: 10 }) {
      Button('选择左侧图标类型')
        .onClick(() => {
          this.selectLeftIconType()
        })
      List(){
        //右侧元素为arrow
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
              arrow: {
                value: $r('app.media.ic_into'),
                action: () => {
                  ToastUtils.show('点击箭头')
                }
              },

            }
          })
            .backgroundColor(Color.White)
        }
        //右侧元素为icon
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
              icon:{
                value:$r('app.media.tab_home_t'),
                action:()=>{
                  ToastUtils.show('第一个图标')
                }
              },
              subIcon:{
                value:$r('app.media.tab_info_t'),
                action:()=>{
                  ToastUtils.show('第二个图标')
                }
              }

            }
          })
            .backgroundColor(Color.White)
        }
        //右侧元素为button
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
              button:{
                text:'按钮'
              }

            }
          })
            .backgroundColor(Color.White)
        }
        //右侧元素为=switch
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
             switch:{
               isCheck:this.rightSwitch,
               onChange:(value:boolean)=>{
                  this.rightSwitch=value
               }
             }

            }
          })
            .backgroundColor(Color.White)
        }
        //右侧元素为checkBox
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
              checkbox:{
                isCheck:this.rightCheckbox,
                onChange:(value:boolean)=>{
                  this.rightCheckbox=value
                }
              }

            }
          })
            .backgroundColor(Color.White)
        }
        //右侧元素为radio
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
              radio:{
                isCheck:this.rightRadio,
                onChange:(value:boolean)=>{
                  this.rightRadio=value
                }
              }

            }
          })
            .backgroundColor(Color.White)
        }
        //右侧元素为image
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
              image:$r('app.media.img1')
            }
          })
            .backgroundColor(Color.White)
        }
        //右侧元素为text
        ListItem(){
          ComposeListItem({
            contentItem: {
              iconStyle: this.leftIconType,
              icon: this.leftIconSrc,
              primaryText: '这是主标题主标题主标题主标题主标题主标题主标题主标题主标题主标题',
              secondaryText: '这是副标题副标题副标题副标题副标题副标题副标题副标题副标题副标题',
              description: '这是描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述'
            },
            operateItem: {
              text:'文本'

            }
          })
            .backgroundColor(Color.White)
        }
      }


    }
    .height('100%')
    .backgroundColor('#f5f5f5')
    .width('100%')
  }

  selectLeftIconType() {
    TextPickerDialog.show({
      range: this.selectLeftIconTypeList,
      selected:this.leftIconType-1,
      canLoop: false,
      onAccept: (value: TextPickerResult) => {
        this.leftIconType = value.index as number + 1
      }
    })
  }
}