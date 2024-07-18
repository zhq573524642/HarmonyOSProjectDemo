import { ArticleBean } from '../../../bean/ArticleBean'
import LazyDataSource from '../../../utils/LazyDataSource'
import { WaterFlowViewModel } from './WaterFlowViewModel'

@Entry
@Component
struct WaterFlowPage {
  private scroller: Scroller = new Scroller()
  @State waterFlowViewModel: WaterFlowViewModel = WaterFlowViewModel.getInstance()
  private datasource: LazyDataSource<ArticleBean> = this.waterFlowViewModel.articleDataSource
  private cacheCount: number = 4;

  aboutToAppear() {
    this.waterFlowViewModel.getArticleData()
  }

  @Builder
  itemFoot() {
    Column() {
      if (this.waterFlowViewModel.pageStatus === 1) {
        Row() {
          LoadingProgress()
            .color(Color.Gray)
            .width(25)
            .height(25)
          Text('正在加载...')
            .fontSize(15)
            .margin({ left: 10 })
            .fontColor(Color.Gray)
        }
      }
      if (!this.waterFlowViewModel.hasNextPageData) {

        Text('已经加载全部数据                                                                      ')
          .fontSize(15)
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontColor(Color.Gray)

      }
    }.width('100%')
    .height(60)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      WaterFlow({ footer: this.itemFoot(), scroller: this.scroller }) {
        LazyForEach(this.datasource, (item: ArticleBean, index: number) => {
          FlowItem() {
            Column() {
              Image(item.img).objectFit(ImageFit.Cover)
                .width('100%')
                .aspectRatio(1)
                .borderRadius({
                  topLeft: 12,
                  topRight: 12,
                  bottomLeft: 0,
                  bottomRight: 0
                })
              Text(item.title)
                .fontSize(15)
                .fontColor(Color.Black)
                .margin(10)

              Text(item.desc)
                .fontSize(13)
                .fontColor(Color.Gray)
                .margin({
                  left: 10,
                  right: 10,
                  bottom: 10
                })
            }
            .alignItems(HorizontalAlign.Start)
            .borderRadius(12)
            .backgroundColor(Color.White)
          }.width('100%')
          .onAppear(() => {
            //触发上拉加载更多
            if ((index + this.cacheCount) === this.datasource.totalCount()) {
              //加载更多
              this.waterFlowViewModel.getArticleData()
            }
          })
          .padding({ left: 10, right: 10 })
        })
      }
      .layoutDirection(FlexDirection.Column)
      .cachedCount(this.cacheCount)
      .columnsTemplate('1fr 1fr') //列的数量
      .columnsGap(10) //列与列的间距
      .rowsGap(10) //行与行的间距
      .itemConstraintSize({
        //宽高范围约束
        minWidth: 0,
        maxWidth: '100%',
        minHeight: 0,
        maxHeight: '100%'
      })
      .width('100%')
    }.width('100%')
    .height('100%')
    .backgroundColor('#f5f5f5')
  }
}