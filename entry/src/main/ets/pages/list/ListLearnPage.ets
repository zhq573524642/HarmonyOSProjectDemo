import { CommonButton, CommonTitle } from '../component/MyComponent';
import { router } from '@kit.ArkUI';
import { RouterUtil } from '@ohos/common';
import { LazyForEachTestPage, LazyForEachTypeEnum } from './LazyForEachTestPage';
import { ListVerticalPage } from './ListVerticalPage';
import { ListSpreadAndFoldPage } from './ListSpreadAndFoldPage';

@Entry({
  routeName: 'ListLearnPage'
})
@Component
export struct ListLearnPage {
  static startPage() {
    RouterUtil.pushNamedRoute('ListLearnPage')
  }

  build() {
    Column() {
      CommonButton({ text: '普通列表List-垂直' })
        .onClick(() => {
          ListVerticalPage.startPage()
        })
      CommonButton({ text: '普通列表List-水平' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListHorizontalPage'
          })
        })
      CommonButton({ text: '侧滑删除Item列表' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListItemDeletePage'
          })
        })
      CommonButton({ text: '列表操作-单选' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListSingleSelectPage'
          })
        })
      CommonButton({ text: '列表操作-多选(@ObservedV2+@Trace)' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListMultipleSelectPage'
          })
        })
      CommonButton({ text: '列表操作-增删改' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListHandlePage'
          })
        })
      CommonButton({ text: '列表操作-ListItemGroup' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListStickPage'
          })
        })
      CommonButton({ text: '列表操作-拖拽' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListItemDragPage'
          })
        })
      CommonButton({ text: '组合组件ComposeListItem（列表）' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ComposeListItemPage'
          })
        })
      CommonButton({text:'List折叠与展开'})
        .onClick(()=>{
           ListSpreadAndFoldPage.startPage()
        })
      CommonTitle({ title: 'lazyForEach操作' })
      CommonButton({ text: 'LazyForEach：增加一条数据' })
        .onClick(() => {
          LazyForEachTestPage.startPage(LazyForEachTypeEnum.ADD_ONE)
        })
      CommonButton({ text: 'LazyForEach：增加多条数据' })
      CommonButton({ text: 'LazyForEach：删除一条数据' })
      CommonButton({ text: 'LazyForEach：删除多条数据' })
      CommonButton({ text: 'LazyForEach：修改一条数据' })
      CommonButton({ text: 'LazyForEach：修改多条数据' })
      CommonButton({ text: 'LazyForEach：修改一条深层数据属性' })

    }
  }
}