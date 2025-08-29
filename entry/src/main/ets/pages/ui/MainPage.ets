import { CommonButton, CommonTitle } from '../component/MyComponent'
import { promptAction, router } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'
import { url } from '@kit.ArkTS'
import { ArkUIPage } from './arkui/ArkUIPage'
import { ArkWebPage } from '../web/ArkWebPage'
import { AnimationPage } from '../animate/AnimationPage'
import { BackgroundTasksPage } from '../background/BackgroundTasksPage'
import { UTDTestPage } from '../data/UTDTestPage'
import { PreferencePage } from '../datastore/PreferencePage'
import { SingleVersionArkDataPage } from '../datastore/SingleVersionArkDataPage'
import { RelationalDataStorePage } from '../datastore/RelationalDataStorePage'
import { DistributedDataObject1Page } from '../datastore/DistributedDataObject1Page'

let uiAbilityLocalStorage = LocalStorage.getShared()

@Entry(uiAbilityLocalStorage)
@Component
struct MainPage {
  private scroller: Scroller = new Scroller()
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  build() {
    Scroll(this.scroller) {
      Column() {
        CommonButton({ text: '测试' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/TestPage'
            })
          })
        CommonButton({ text: 'ArkTS基础' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ui/arkts/ArkTSBasePage'
            })
          })
        CommonButton({ text: 'ArkUI组件' })
          .onClick(() => {
            ArkUIPage.startPage()
          })
        CommonButton({ text: '网络' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/network/NetworkTestPage'
            })
          })
        CommonButton({ text: '动画' })
          .onClick(() => {
            AnimationPage.startPage()
          })

        CommonButton({ text: 'ArkWeb' })
          .onClick(() => {

            // router.pushUrl({
            //   url: 'pages/web/WebPage',
            //   params: {
            //     web_url: 'https://beta-app.yiboshi.com/appAgreement/ybs'
            //   }
            // })
            ArkWebPage.startPage()
          })
        CommonTitle({ title: 'Background Tasks Kit（后台任务开发服务）' })
        CommonButton({ text: '后台任务测试' })
          .onClick(() => {
            BackgroundTasksPage.startPage()
          })
        CommonTitle({ title: 'Form Kit（卡片开发服务）' })
        CommonButton({ text: '创建桌面卡片' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/form/FormMenuPage'
            })
          })
        CommonTitle({ title: 'ArkData' })
        CommonButton({ text: '自定义UTD标准化数据类型' })
          .onClick(() => {
            UTDTestPage.startPage()
          })
        CommonButton({ text: '用户首选项实现数据持久化' })
          .onClick(() => {
            PreferencePage.startPage()
          })
        CommonButton({ text: '键值型数据库实现数据持久化和分布式同步' })
          .onClick(() => {
            SingleVersionArkDataPage.startPage()
          })
        CommonButton({ text: '关系型数据库实现数据持久化和分布式同步' })
          .onClick(() => {
            RelationalDataStorePage.startPage()
          })
        CommonButton({ text: '分布式数据对象跨设备同步:跨端迁移' })
          .onClick(() => {
            DistributedDataObject1Page.startPage()
          })
        CommonButton({ text: '分布式数据对象跨设备同步:多端协同' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/datastore/DistributedDataObject2Page'
            })
          })
        CommonTitle({ title: 'Core File Kit（文件基础服务）' })
        CommonButton({ text: '获取应用文件路径' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/file/AppFilePathPage'
            })
          })
        CommonButton({ text: '应用文件操作' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/file/ApplicationFilePage'
            })
          })
        CommonButton({ text: '用户文件操作' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/file/UserFilePage'
            })
          })
        CommonTitle({ title: 'Location Kit 位置服务' })
        CommonButton({ text: '获取位置信息' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/location/LocationKitPage'
            })
          })
        CommonTitle({ title: '短距通信服务' })
        CommonButton({ text: '蓝牙' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/bluetooth/BlueToothTestPage'
            })
          })
        CommonTitle({ title: 'Camera Kit（相机服务）' })
        CommonButton({ text: '相机开发' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/camera/CameraKitPage'
            })
          })
        CommonButton({ text: '相机选择器' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/media/CameraPickerPage'
            })
          })
        CommonTitle({ title: 'Media Library Kit（媒体文件管理服务）' })
        CommonButton({ text: '使用Picker选择媒体库资源' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/media/PickerPage'
            })
          })

        CommonButton({ text: 'AlbumPickerComponent' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/media/AlbumPickerComponentPage'
            })
          })
        CommonButton({ text: 'PhotoPickerComponent' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/media/PhotoPickerComponentPage'
            })
          })
        CommonTitle({ title: 'Audio Kit' })
        CommonTitle({ title: 'PDF Kit' })
        CommonButton({ text: 'PdfView' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/media/PdfViewPage'
            })
          })
        CommonTitle({ title: 'Core Vision Kit（基础视觉服务）' })
        CommonButton({ text: '文字识别' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ai/TextRecognitionPage'
            })
          })
        CommonButton({ text: '人脸识别' })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ai/FaceDetectorPage'
            })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

    }.width('100%')
  }
}