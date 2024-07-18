import { CommonButton } from '../component/MyComponent';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ListLearnPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      CommonButton({ text: '普通列表List-垂直' })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/list/ListVerticalPage'
          })
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
      CommonButton({text:'列表操作-单选'})
        .onClick(()=>{
          router.pushUrl({
            url: 'pages/list/ListSingleSelectPage'
          })
        })
      CommonButton({text:'列表操作-多选(@ObservedV2+@Trace)'})
        .onClick(()=>{
          router.pushUrl({
            url: 'pages/list/ListMultipleSelectPage'
          })
        })
      CommonButton({text:'列表操作-增删改'})
        .onClick(()=>{
          router.pushUrl({
            url: 'pages/list/ListHandlePage'
          })
        })
      CommonButton({text:'列表操作-ListItemGroup'})
        .onClick(()=>{
          router.pushUrl({
            url: 'pages/list/ListStickPage'
          })
        })
      CommonButton({text:'列表操作-拖拽'})
        .onClick(()=>{
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
    }
  }
}