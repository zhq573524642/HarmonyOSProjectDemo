import { RouterUtil } from '@ohos/common';
import { Person } from '../list/Person'

@Entry({ routeName: 'GridRowPage' })
@Component
export struct GridRowPage {
  static startPage() {
    RouterUtil.pushNamedRouteSingle('GridRowPage')
  }

  @State bgColors: Color[] =
    [Color.Red, Color.Orange, Color.Yellow, Color.Green, Color.Pink, Color.Grey, Color.Blue, Color.Brown];

  build() {
    GridRow({
      direction: GridRowDirection.Row,//子组件排列方向
      gutter: { x: 10, y: 20 },//子组件间距
      breakpoints: {//断点
        value: ['200vp', '300vp', '400vp', '500vp', '600vp'],
        reference: BreakpointsReference.WindowSize
      },
      columns: {//不同断点区间下将屏幕宽度分为不同的列数
        xs: 2, // 在最小宽度类型设备上，栅格子组件占据的栅格容器2列。
        sm: 3, // 在小宽度类型设备上，栅格子组件占据的栅格容器3列。
        md: 4, // 在中等宽度类型设备上，栅格子组件占据的栅格容器4列。
        lg: 6, // 在大宽度类型设备上，栅格子组件占据的栅格容器6列。
        xl: 8, // 在特大宽度类型设备上，栅格子组件占据的栅格容器8列。
        xxl: 12 // 在超大宽度类型设备上，栅格子组件占据的栅格容器12列。
      }
    }) {
      ForEach(this.bgColors, (color: Color, index?: number | undefined) => {
        GridCol({
          // span: 1,//每个子组件占用上面分成列数的多少列，（比如这里每个子组件占用一列）
          span:{
            //上面分的列数时子组件在对应的列数占据多少列（比如这里屏幕符合md，屏幕被分为4列，
            // 对应md子组件占据2列，显示出来就是每行有2个子组件）
            xs:1,
            sm:2,
            md:2,
            lg:3,
            xl:4,
            xxl:6,
          },
          // offset:1,//偏移：根据上面分的列数，偏移多少列，
          order:index//栅格子组件的序号，决定子组件排列次序。
        }) {
          Row() {
            Text(`${index}`)
          }.width("100%").height('50vp')
        }.backgroundColor(color)
      })
    }
  }

  @State dataList: Array<Person> = []

  aboutToAppear(): void {
    for (let i = 0; i < 20; i++) {
      this.dataList.push(new Person('姓名-' + i, '男', '17610676602'))
    }
  }
}