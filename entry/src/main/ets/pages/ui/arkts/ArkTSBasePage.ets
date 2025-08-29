import { CommonButton, CommonTitle } from '../../component/MyComponent'
import { router } from '@kit.ArkUI'
import { UIAbility, common, OpenLinkOptions, Want } from '@kit.AbilityKit'
import { PermissionUtils, ToastUtils } from '@ohos/common'
import { BusinessError } from '@kit.BasicServicesKit'
import { productViewManager } from '@kit.StoreKit'
import { call } from '@kit.TelephonyKit'
import { calendarManager } from '@kit.CalendarKit'
import { DataStructurePage } from '../../data/DataStructurePage'

@Entry
@Component
struct ArkTSBasePage {
  private context = getContext(this) as common.UIAbilityContext
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '数据结构' })
          .onClick(() => {
            DataStructurePage.startPage()
          })
        CommonButton({ text: '权限申请' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/permission/PermissionsPage'
            })
          })
        CommonButton({ text: '状态控制' })
          .onClick(() => {
            router.pushUrl({ url: 'pages/state/StateManagerPage' })
          })
        CommonButton({ text: '装饰器' })
          .onClick(() => {
            // this.context.currentHapModuleInfo.
            router.pushUrl({
              url: 'pages/decorator/ArkDecoratorPage'
            })
          })
        CommonButton({ text: '并发' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/concurrency/ConcurrencyPage'
            })
          })
        CommonButton({ text: '数据传递和消息通信' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkts/MessageTransmitPage'
            })
          })

        CommonTitle({ title: '应用程序包' })
        CommonButton({ text: 'HAR（静态共享包）' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkts/HarLibPage'
            })
          })
        CommonButton({ text: 'HSP（动态共享包）' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkts/HspLibPage'
            })
          })
        CommonButton({ text: 'UIAbility' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkts/AbilityTestPage'
            })
          })
        CommonButton({ text: '信息传递载体Want' })
        CommonTitle({ title: '应用间跳转' })
        CommonButton({ text: 'DeepLink：openLink()' })
          .onClick(() => {
            let link: string = "zhq://www.zhqdemo.com:8090/home";
            let openLinkOptions: OpenLinkOptions = {
              appLinkingOnly: false
            };
            try {
              this.context.openLink(link, openLinkOptions)
                .then(() => {
                  ToastUtils.show('启动成功')
                })
                .catch((e: BusinessError) => {
                  ToastUtils.show('启动失败：' + e.message)
                })
            } catch (e) {
            }
          })
        CommonButton({ text: 'DeepLink：startAbility()' })
          .onClick(() => {
            let want: Want = {
              action: 'ohos.want.action.viewData',
              uri: 'zhq://www.zhqdemo.com:8090/home'
            }
            this.context.startAbility(want)
              .then(() => {
                ToastUtils.show('启动成功')
              })
              .catch((e: BusinessError) => {
                ToastUtils.show('启动失败：' + e.message)
              })
          })
        CommonTitle({ title: '拉起系统应用' })
        CommonButton({ text: '拉起应用市场' })
          .onClick(() => {
            let want: Want = {
              parameters: {
                // 此处填入要加载的应用包名，例如： bundleName: "com.huawei.hmsapp.appgallery"
                bundleName: 'com.huawei.hmsapp.appgallery'
              }
            }
            productViewManager.loadProduct(this.context,want)
          })
        CommonButton({text:'拉起打电话'})
          .onClick(()=>{
            try {
              call.makeCall('17610676602', (e: BusinessError) => {
                  console.debug('===拉起打电话失败：' + e.message)
              })
            } catch (e) {
            }
          })
        CommonButton({text:'拉起日历创建日程'})
          .onClick(()=>{
            PermissionUtils.getInstance().checkPermissions(['ohos.permission.READ_CALENDAR','ohos.permission.WRITE_CALENDAR'],(isAllGrant:boolean)=>{
              if (isAllGrant) {
                 this.createCalendar()
              }else {
                PermissionUtils.getInstance().reqPermissionsFromUser(this.context,['ohos.permission.READ_CALENDAR',
                  'ohos.permission.WRITE_CALENDAR'],(result:boolean)=>{
                  if (result) {
                    this.createCalendar()
                  }else {
                    PermissionUtils.getInstance().openPermissionsInSystemSettings(this.context,this.context.abilityInfo.bundleName)
                  }
                })
              }
            })

          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }.width('100%')

  }

  createCalendar(){
    let date=new Date()
    let event:calendarManager.Event={
      type:calendarManager.EventType.NORMAL,
      startTime:date.getTime(),
      endTime:date.getTime()+60*60*1000,
      title:'测试日程',
      description:'aaaaaaaaaaaaaaaa'
    }
    calendarManager.getCalendarManager(this.context)?.getCalendar()
      .then((data:calendarManager.Calendar)=>{
        data.addEvent(event,(e:BusinessError,id:number)=>{
          if (e) {
            console.debug('===创建日程失败1：'+e.message)
          }else {
            ToastUtils.show('创建日程成功：'+id)
          }
        })
      })
      .catch((e:BusinessError)=>{
        console.debug('===创建日程失败2：'+e.message)
      })
  }
}



