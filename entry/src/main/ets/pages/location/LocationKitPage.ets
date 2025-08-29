import { PermissionUtils } from '@ohos/common'
import { CommonButton } from '../component/MyComponent'
import { common, Permissions } from '@kit.AbilityKit'
import { geoLocationManager } from '@kit.LocationKit'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct LocationKitPage {
  private context = getContext(this) as common.UIAbilityContext
  private locationPermissionArr: Array<Permissions> = ['ohos.permission.LOCATION',
    'ohos.permission.LOCATION_IN_BACKGROUND'
    , 'ohos.permission.APPROXIMATELY_LOCATION']
  @State isLocationPermissions: boolean = false
  @State locationInfo: string = ''

  aboutToAppear(): void {
    // PermissionUtils.getInstance().checkPermissions(this.locationPermissionArr, (isAllGrant: boolean,deniedPermissions:Permissions[]) => {
    //   this.isLocationPermissions = isAllGrant
    // })
  }

  build() {
    Column() {
      CommonButton({ text: '获取定位权限' })
        .onClick(() => {
          this.checkLocationPermissions()
        })
      Text(`当前定位：\n${this.locationInfo}`).fontSize(18).fontColor(Color.Red)
        .margin({ top: 10, bottom: 10 })
      CommonButton({ text: '获取系统缓存的最新位置' })
        .onClick(() => {
          this.getCacheLocation()
        })
    }
  }

  checkLocationPermissions() {
    PermissionUtils.getInstance().checkPermissions(this.locationPermissionArr, (isAllGrant: boolean,deniedPermissions:Permissions[]) => {
      if (isAllGrant) {
        this.isLocationPermissions = true
      } else {
        this.requestLocationPermission()
      }
    })
  }

  requestLocationPermission() {
    PermissionUtils.getInstance()
      .reqPermissionsFromUser(this.context, this.locationPermissionArr, (isAllGrant: boolean,deniedPermission:Array<Permissions>) => {
        if (isAllGrant) {
          this.isLocationPermissions = true
        } else {
          PermissionUtils.getInstance()
            .openPermissionsInSystemSettings(this.context, this.context.abilityInfo.bundleName)
        }
      })
  }

  getCacheLocation() {
    try {
      let location = geoLocationManager.getLastLocation()
    } catch (e) {
      let err: BusinessError = e as BusinessError
      console.debug('===获取缓存位置信息失败：' + err.message)
    }
  }

  getCurrentLocation(priority: number) {
    //构造
    let locationRequest: geoLocationManager.SingleLocationRequest = {
      locatingPriority: priority === 1 ? geoLocationManager.LocatingPriority.PRIORITY_ACCURACY :
      geoLocationManager.LocatingPriority.PRIORITY_ACCURACY,
      locatingTimeoutMs: 10000
    }
    try {
      geoLocationManager.getCurrentLocation(locationRequest)
        .then((result: geoLocationManager.Location) => {
          let s = '纬度:' + result.latitude + '\n经度:' + result.longitude + '\n'
            + '高度:' + result.altitude + '\n'
            + '高度信息精度(米):' + result.altitudeAccuracy + ''
            + '精度信息:' + result.accuracy + '\n'
            + '速度信息:' + result.speed + '\n'
            + '速度信息精度(米每秒):' + result.speedAccuracy + '\n'
            + '位置时间戳(UTC格式):' + result.timeStamp + '\n'
            + '航向信息(度):' + result.direction + '\n'
            + '位置时间戳(开始时间格式):' + result.timeSinceBoot
          this.locationInfo = s
        })
        .catch((error: BusinessError) => {
          console.debug('===获取当前定位失败：' + error.message)
        })
    } catch (e) {
      let err = e as BusinessError
      console.debug('===获取当前定位异常：' + err.message)
    }

  }
}