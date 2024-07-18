let NextID: number = 0

@Observed
export class ArticleBean {
  img: ResourceStr
  title: string
  desc: string
  id: number

  constructor(img: ResourceStr, title: string, desc: string) {
    this.id = NextID++
    this.img = img
    this.title = title
    this.desc = desc
  }
}