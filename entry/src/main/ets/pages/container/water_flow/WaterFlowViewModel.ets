import { ArticleBean } from '../../../bean/ArticleBean'
import LazyDataSource from '../../../utils/LazyDataSource'

export class WaterFlowViewModel {
  private static instance: WaterFlowViewModel
  articleDataSource: LazyDataSource<ArticleBean> = new LazyDataSource()
  private images: Array<ResourceStr> = [$r('app.media.img1'), $r('app.media.img2'), $r('app.media.img3')]
  private desc: string[] = ['今天是个好日子啊~', '我们都是个还哦哦热键大家客家话空间环境开会客家话',
    '大大简单快捷卡机卡机卡卡借记卡角度看开几把科技博客博客看几百块几百块几百块几百块举报']
  hasNextPageData: boolean = true
  pageStatus: number = 0

  public static getInstance(): WaterFlowViewModel {
    if (!WaterFlowViewModel.instance) {
      WaterFlowViewModel.instance = new WaterFlowViewModel()
    }
    return WaterFlowViewModel.instance
  }

  getArticleData() {
    if (this.hasNextPageData) {
      if (this.articleDataSource.totalCount() === 0) {
        for (let i = 0; i < 20; i++) {
          this.articleDataSource.pushData(new ArticleBean(this.images[i%3], 'Title-' + i, this.desc[i%3]))
        }
        this.hasNextPageData = this.articleDataSource.totalCount() <100
        console.debug('===数据量：' + this.articleDataSource.totalCount() + '--' + this.hasNextPageData)
      } else {
        this.pageStatus = 1
        setTimeout(() => {
          for (let i = 0; i < 20; i++) {
            this.articleDataSource.pushData(new ArticleBean(this.images[i%3], 'Title-' + i, this.desc[i%3]))
          }
          this.pageStatus = 0
          this.hasNextPageData = this.articleDataSource.totalCount() < 100
          console.debug('===数据量：' + this.articleDataSource.totalCount() + '--' + this.hasNextPageData)
        }, 2000)
      }
    } else {
      this.pageStatus = 0
      console.debug('===数据量：' + this.articleDataSource.totalCount() + '--' + this.hasNextPageData)
    }


  }
}