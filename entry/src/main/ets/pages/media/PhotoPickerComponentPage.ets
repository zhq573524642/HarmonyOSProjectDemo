import {
  ClickType,
  DataType,
  ItemInfo,
  ItemType,
  MaxCountType,
  MaxSelected,
  PhotoBrowserInfo,
  PhotoPickerComponent,
  PickerColorMode,
  PickerController,
  PickerOptions,
  PickerOrientation,
  ReminderMode,
  SelectMode
} from '@ohos.file.PhotoPickerComponent'
import { ArrayList } from '@kit.ArkTS'
import photoAccessHelper from '@ohos.file.photoAccessHelper'

@Entry
@Component
struct PhotoPickerComponentPage {
  pickerOptions: PickerOptions = new PickerOptions()
  @State pickerController: PickerController = new PickerController()
  @State selectedList: ArrayList<string> = new ArrayList()

  aboutToAppear(): void {
    this.pickerOptions.checkBoxColor = '#ffff0000'; //勾选框的背景色。格式为8位十六进制颜色代码。string
    this.pickerOptions.backgroundColor = '#ffffffff'; //picker宫格页面背景色。格式为8位十六进制颜色代码。
    this.pickerOptions.isRepeatSelectSupported = false; //是否支持单张图片重复选择。true表示支持。
    this.pickerOptions.checkboxTextColor = '#ff000000'; //勾选框内文本颜色。格式为8位十六进制颜色代码。 （该能力暂不支持）
    this.pickerOptions.photoBrowserBackgroundColorMode = PickerColorMode.AUTO; //大图背景颜色。包括跟随系统、浅色模式以及深色模式，默认为跟随系统。
    this.pickerOptions.maxSelectedReminderMode = ReminderMode.MASK; //选择数量达到最大时的提示方式。包括弹toast提示、不提示以及蒙层提示，默认为弹toast提示。
    this.pickerOptions.orientation = PickerOrientation.VERTICAL; //宫格页面滑动预览方向，包括水平和竖直两个方向，默认为竖直方向。（该能力暂不支持）
    this.pickerOptions.selectMode = SelectMode.MULTI_SELECT; //选择模式。包括多选和单选，默认为多选。
    this.pickerOptions.maxPhotoSelectNumber = 9; //图片最大的选择数量。最大值为500，受到最大选择总数的限制。
    this.pickerOptions.maxVideoSelectNumber = 4; //视频最大的选择数量。最大值为500，受到最大选择总数的限制。
    this.pickerOptions.isSearchSupported = false; //是否支持搜索
    this.pickerOptions.isPhotoTakingSupported = true;//是否支持拍照
    this.pickerOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; //picker展示的类型
  }

  build() {
    Column({ space: 10 }) {
      Text('PickerController')
      Button('setData')
        .onClick(() => {
          //DataType.SET_SELECTED_URIS
          //发送已选择的数据列表，通知picker组件勾选状态刷新，需要传入string数组类型。
          // 例如：应用在自己的页面中删除某张图片后，需要把剩下的已选择的数据列表通过setData接口通知到picker组件，
          // 从而触发picker组件勾选框状态刷新正确。
          //DataType.SET_ALBUM_URI
          this.pickerController.setData(DataType.SET_SELECTED_URIS, this.selectedList)
        })
      Button('setMaxSelected').onClick(() => {
        let map: Map<MaxCountType, number> = new Map()
        map.set(MaxCountType.PHOTO_MAX_COUNT, 9)
        map.set(MaxCountType.VIDEO_MAX_COUNT, 5)
        map.set(MaxCountType.TOTAL_MAX_COUNT, 14)
        this.pickerController.setMaxSelected({ data: map })
      })
      PhotoPickerComponent({
        pickerOptions: this.pickerOptions,
        pickerController: this.pickerController,
        onSelect: (uri: string) => {
          //用户在Picker组件中勾选图片时产生的回调事件，将图片uri报给应用。
          // this.selectedList.add(uri)
          // this.pickerController.setData(DataType.SET_SELECTED_URIS, this.selectedList)
        },
        onDeselect: (uri: string) => {
          //用户在Picker组件中取消勾选图片时产生的回调事件，同时也会将图片uri报给应用。

        },
        onItemClicked: (itemInfo: ItemInfo, clickType: ClickType): boolean => {
          // 用户在picker组件中点击item产生的回调事件。
          // 点击图片（缩略图item）时，返回值为true则勾选此图片，否则不勾选；点击相机item，返回值为true则拉起系统相机，否则应用自行处理。
          //ItemInfo中参数
          //1.itemType:ItemType.THUMBNAIL 图片视频缩略图  ItemType.CAMERA相机
          //2.uri:string：图片、视频的uri，ItemType.THUMBNAIL时支持
          //3.mimeType:string：图片、视频的mimeType（itemType为ThUMBNAIL时支持，否则为空）。
          //4.width:number：图片、视频的宽（单位：像素）（itemType为ThUMBNAIL时支持，否则为空）。
          //5.height:number：图片、视频的高（单位：像素）（itemType为ThUMBNAIL时支持，否则为空）。
          //6.size:number：图片、视频的大小（单位：千字节）（itemType为ThUMBNAIL时支持，否则为空）。
          //7.duration:number：视频的时长（单位：毫秒），图片时返回-1（itemType为ThUMBNAIL时支持，否则为空）
          //ClickType
          //1.ClickType.SELECTED 选择操作（勾选图片或者点击相机item）。
          //2.ClickType.DESELECTED  取消选择操作（取消勾选图片）。
          if (itemInfo.itemType == ItemType.THUMBNAIL) {
            if (clickType == ClickType.SELECTED) {
              this.selectedList.add(itemInfo.uri)
              return true
            } else {
              this.selectedList.remove(itemInfo.uri)
              return false
            }
          } else {
            return true
          }
        },
        onEnterPhotoBrowser: (photoBrowserInfo: PhotoBrowserInfo): boolean => {
          //点击进入大图时产生的回调事件，将大图相关信息报给应用。
          return false
        },
        onExitPhotoBrowser: (photoBrowserInfo: PhotoBrowserInfo): boolean => {
          // 退出大图时产生的回调事件，将大图相关信息报给应用。
          return false
        },
        onPickerControllerReady: () => {
          //当pickerController可用时产生的回调事件。
          // 调用PickerController相关接口需在该回调后才能生效。
        }
      })
        .enabled(true)
        .width('100%')
        .layoutWeight(1)

    }
    .width('100%')
  }
}