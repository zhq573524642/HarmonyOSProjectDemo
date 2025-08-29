import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { CommonButton } from '../component/MyComponent'
import { BusinessError } from '@kit.BasicServicesKit'
import { LengthMetrics } from '@kit.ArkUI'

@Entry
@Component
struct PickerPage {
  //创建图片-音频类型文件选择选项实例
  photoSelectOptions = new photoAccessHelper.PhotoSelectOptions()
  //获取PhotoViewPicker
  photoViewPicker = new photoAccessHelper.PhotoViewPicker()
  //选择的结果
  selectedUriList: string[] = []

  aboutToAppear(): void {
    //选择媒体文件类型和选择媒体文件的最大数目
    this.photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
    this.photoSelectOptions.maxSelectNumber = 5
  }

  build() {
    Column() {
      CommonButton({ text: '设置选择媒体文件类型' })
      CommonButton({ text: '选择' })
        .onClick(() => {
          this.photoViewPicker.select(this.photoSelectOptions)
            .then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
              this.selectedUriList = photoSelectResult.photoUris
              console.debug('===选择的数据'+this.selectedUriList.length)
            })
            .catch((error: BusinessError) => {

            })
        })
      Flex({wrap:FlexWrap.Wrap,direction:FlexDirection.Row,space:{main:LengthMetrics.vp(10),cross:LengthMetrics.vp(10)}}){
        ForEach(this.selectedUriList,(item:string)=>{
           Image(item)
             .width(80)
             .height(80)
             .objectFit(ImageFit.Cover)
        },(item:string)=>item)
      }
    }
    .height('100%')
    .width('100%')
  }
}