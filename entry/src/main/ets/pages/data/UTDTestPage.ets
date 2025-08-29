import { uniformTypeDescriptor } from "@kit.ArkData"
import { RouterUtil } from "@ohos/common"
import { CommonButton } from "../component/MyComponent"
import { BusinessError } from "@kit.BasicServicesKit"

@Entry({ routeName: 'UTDTestPage' })
@Component
export struct UTDTestPage {
  static startPage() {
    RouterUtil.pushNamedRoute('UTDTestPage')
  }

  build() {
    Column() {
      CommonButton({ text: '查询媒体类文件归属类型' })
        .onClick(() => {
          uniformTypeDescriptorTest()
        })

      CommonButton({ text: '查询自定义自定义数据类型' })
        .onClick(() => {
          getCustomDataTypeByFileExtension()
        })

      CommonButton({ text: '通过文件后缀获取对应的MIMEType列表' })
        .onClick(() => {
          getMIMETypeByFileExtension()
        })

      CommonButton({ text: '通过MIMEType获取对应的后缀列表' })
        .onClick(() => {
          getFileExtensionByMIMEType()
        })
    }
    .width('100%')
    .height('100%')
  }
}

function uniformTypeDescriptorTest() {
  try { // 2.可根据 “.mp3” 文件后缀FilenameExtension查询对应UTD数据类型，并查询对应UTD数据类型的具体属性
    let fileExtension = '.mp3'
    let typeIds1 = uniformTypeDescriptor.getUniformDataTypesByFilenameExtension(fileExtension)
    if (typeIds1.length == 0) {
      return
    }

    let typeObj1 = uniformTypeDescriptor.getTypeDescriptor(typeIds1[0])
    console.debug('===typeId1:' + typeObj1.typeId)
    console.debug('===belongingToTypes1:' + typeObj1.belongingToTypes.toString())
    console.debug('===description1:' + typeObj1.description)
    console.debug('===referenceURL1:' + typeObj1.referenceURL)
    console.debug('===filenameExtensions1:' + typeObj1.filenameExtensions.toString())
    console.debug('===mimeTypes1:' + typeObj1.mimeTypes.toString())

    // 3.可根据 “audio/mp3” MIMEType查询对应UTD数据类型，并查询对应UTD数据类型的具体属性。
    let mineType = 'audio/mp3';
    let typeIds2 = uniformTypeDescriptor.getUniformDataTypesByMIMEType(mineType);
    if (typeIds2.length == 0) {
      return;
    }
    let typeObj2 = uniformTypeDescriptor.getTypeDescriptor(typeIds2[0]);
    console.info('===typeId2:' + typeObj2.typeId);
    console.info('===belongingToTypes2:' + typeObj2.belongingToTypes);
    console.info('===description2:' + typeObj2.description);
    console.info('===referenceURL2:' + typeObj2.referenceURL);
    console.info('===filenameExtensions2:' + typeObj2.filenameExtensions);
    console.info('===mimeTypes2:' + typeObj2.mimeTypes);

    // 4.将数据类型进行比较，确认是否同一种数据类型
    if (typeObj1 != null && typeObj2 != null) {
      let ret = typeObj1.equals(typeObj2);
      console.info('===typeObj1 equals typeObj2, ret:' + ret);
    }

    // 5.将查询到的标准数据类型“general.mp3”与表示音频数据的已知标准数据类型“general.audio”做比较查询，确认是否存在归属关系。
    if (typeObj1 != null) {
      let ret = typeObj1.belongsTo('general.audio');
      console.info('===belongsTo, ret:' + ret);
      let mediaTypeObj = uniformTypeDescriptor.getTypeDescriptor('general.media');
      ret = mediaTypeObj.isHigherLevelType('general.audio'); // 确认是否存在归属关系
      console.info('===isHigherLevelType, ret:' + ret);
    }
  } catch (e) {
    let error = e as BusinessError
    console.debug(`===异常：${error.name}--${error.message}--${error.code}`)
  }
}

function getCustomDataTypeByFileExtension() {
  try {
    let fileExtension = '.myImage'
    let typeIds1 = uniformTypeDescriptor.getUniformDataTypesByFilenameExtension(fileExtension)
    if (typeIds1.length == 0) {
      return
    }

    let typeObj1 = uniformTypeDescriptor.getTypeDescriptor(typeIds1[0])
    console.debug('===typeId1:' + typeObj1.typeId)
    console.debug('===belongingToTypes1:' + typeObj1.belongingToTypes.toString())
    console.debug('===description1:' + typeObj1.description)
    console.debug('===referenceURL1:' + typeObj1.referenceURL)
    console.debug('===filenameExtensions1:' + typeObj1.filenameExtensions.toString())
    console.debug('===mimeTypes1:' + typeObj1.mimeTypes.toString())
  } catch (e) {
    console.debug('===异常：' + e.message + '--' + e.code)
  }
}

function getMIMETypeByFileExtension() {
  try {
    // 2.可根据 “.ts” 文件后缀查询对应UTD数据类型。
    let fileExtention = '.ts';
    let typeIds = uniformTypeDescriptor.getUniformDataTypesByFilenameExtension(fileExtention);
    for (let typeId of typeIds) {
      // 3.根据UTD数据类型查询对应的MIMEType列表。
      let typeObj = uniformTypeDescriptor.getTypeDescriptor(typeId);
      let mimeTypes = typeObj.mimeTypes;
      console.info('===mimeTypes:' + mimeTypes);
    }
  } catch (err) {
    console.error('err message:' + err.message + ', err code:' + err.code);
  }
}

function getFileExtensionByMIMEType() {
  try {
    // 2.可根据 “text/plain” MIMEType查询对应UTD数据类型。
    let mineType = 'text/plain';
    let typeIds = uniformTypeDescriptor.getUniformDataTypesByMIMEType(mineType);
    for (let typeId of typeIds) {
      // 3. 根据UTD数据类型查询对应的MIMEType列表
      let typeObj = uniformTypeDescriptor.getTypeDescriptor(typeId);
      let filenameExtensions = typeObj.filenameExtensions;
      console.info('===filenameExtensions:' + filenameExtensions);
    }
  } catch (err) {
    console.error('err message:' + err.message + ', err code:' + err.code);
  }
}