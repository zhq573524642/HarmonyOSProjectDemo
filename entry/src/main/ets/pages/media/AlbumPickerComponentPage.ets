import { AlbumInfo, AlbumPickerComponent } from '@ohos.file.AlbumPickerComponent'
import { PickerColorMode } from '@ohos.file.PhotoPickerComponent'

@Entry
@Component
struct AlbumPickerComponentPage {

  build() {
    Column(){
       AlbumPickerComponent({albumPickerOptions:{themeColorMode:PickerColorMode.AUTO},onAlbumClick:(albumInfo:AlbumInfo):boolean =>
       this.handleAlbumInfo(albumInfo)})
    }.width('100%')
  }

  handleAlbumInfo(albumInfo:AlbumInfo):boolean{
    if (albumInfo?.uri) {
       
    }
    return true

  }
}