import { Person } from '../list/Person'

@Entry
@Component
struct GridRowPage {
  // @State bgColors: Color[] = [Color.Red, Color.Orange, Color.Yellow, Color.Green, Color.Pink, Color.Grey, Color.Blue, Color.Brown];
  // build() {
  //   GridRow({
  //     breakpoints: {
  //       value: ['200vp', '300vp', '400vp', '500vp', '600vp'],
  //       reference: BreakpointsReference.WindowSize
  //     }
  //   }) {
  //     ForEach(this.bgColors, (color:Color, index?:number|undefined) => {
  //       GridCol({
  //         span: {
  //           xs: 2, // 在最小宽度类型设备上，栅格子组件占据的栅格容器2列。
  //           sm: 3, // 在小宽度类型设备上，栅格子组件占据的栅格容器3列。
  //           md: 4, // 在中等宽度类型设备上，栅格子组件占据的栅格容器4列。
  //           lg: 6, // 在大宽度类型设备上，栅格子组件占据的栅格容器6列。
  //           xl: 8, // 在特大宽度类型设备上，栅格子组件占据的栅格容器8列。
  //           xxl: 12 // 在超大宽度类型设备上，栅格子组件占据的栅格容器12列。
  //         }
  //       }) {
  //         Row() {
  //           Text(`${index}`)
  //         }.width("100%").height('50vp')
  //       }.backgroundColor(color)
  //     })
  //   }
  // }
  @State dataList: Array<Person> = []

  aboutToAppear(): void {
    for (let i = 0; i < 20; i++) {
       this.dataList.push(new Person('姓名-'+i,'男','17610676602'))
    }
  }

  build() {
     Column(){

     }
  }
}