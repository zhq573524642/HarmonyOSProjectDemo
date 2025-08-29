import { PdfView, pdfViewManager } from '@hms.officeservice.PdfView'
import { common } from '@kit.AbilityKit'
import pdfService from '@hms.officeservice.pdfservice'
import fileIo from '@ohos.file.fs'
import { LengthMetrics } from '@kit.ArkUI'

@Entry
@Component
struct PdfViewPage {
  controller = new pdfViewManager.PdfController()
  @State pageFit: pdfService.PageFit = pdfService.PageFit.FIT_NONE
  @State pageLayout: pdfService.PageLayout = pdfService.PageLayout.LAYOUT_SINGLE

  aboutToAppear(): void {
    let context = getContext() as common.UIAbilityContext;
    let dir: string = context.filesDir
    // 确保在工程目录src/main/resources/rawfile里有pdf_reference.pdf文件
    let filePath: string = dir + "/book2019.pdf";
    fileIo.accessSync(filePath);
    let content: Uint8Array = context.resourceManager.getRawFileContentSync('rawfile/book2019.pdf');
    let fdSand = fileIo.openSync(filePath, fileIo.OpenMode.WRITE_ONLY | fileIo.OpenMode.CREATE | fileIo.OpenMode.TRUNC);
    fileIo.writeSync(fdSand.fd, content.buffer);
    fileIo.closeSync(fdSand.fd);

    (async () => {
      this.controller.registerPageCountChangedListener((pageCount: number) => {
        console.info('TAG', '===registerPageCountChanged-', pageCount.toString());
      });
      let loadResult1: pdfService.ParseResult = await this.controller.loadDocument(filePath);
    })()
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.BottomStart }) {
        PdfView({
          controller: this.controller,
          pageFit: this.pageFit,
          pageLayout: this.pageLayout,
          showScroll: true
        })
          .width('100%')
          .layoutWeight(1)
        Flex({
          wrap: FlexWrap.Wrap,
          direction: FlexDirection.Row,
          space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) }
        }) {
          Button('PageFit')
            .onClick(() => {
              this.changePageFit()
            })
          Button('PageLayout')
            .onClick(() => {
              if (this.pageLayout === pdfService.PageLayout.LAYOUT_SINGLE) {
                this.pageLayout = pdfService.PageLayout.LAYOUT_DOUBLE
              } else {
                this.pageLayout = pdfService.PageLayout.LAYOUT_SINGLE
              }
            })
        }
      }

    }.width('100%')
    .height('100%')
  }

  private changePageFit() {
    TextPickerDialog.show({
      range: ['FIT_NONE', 'FIT_PAGE', 'FIT_WIDTH', 'FIT_HEIGHT'],
      canLoop: false,
      onAccept: (value: TextPickerResult) => {
        switch (value.index) {
          case 0:
            this.pageFit = pdfService.PageFit.FIT_NONE
            break
          case 1:
            this.pageFit = pdfService.PageFit.FIT_PAGE
            break
          case 2:
            this.pageFit = pdfService.PageFit.FIT_WIDTH
            break
          case 3:
            this.pageFit = pdfService.PageFit.FIT_HEIGHT
            break
        }
      }
    })
  }
}