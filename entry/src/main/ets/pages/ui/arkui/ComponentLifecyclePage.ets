@Entry
@Component
struct ComponentLifecyclePage {
  @State num: number = 0
  aboutToAppear(): void {
    console.debug('===父-aboutToAppear')
  }

  onDidBuild(): void {
    console.debug('===父-onDidBuild')
  }

  onPageShow(): void {
    console.debug('===父-onPageShow')
  }

  onPageHide(): void {
    console.debug('===父-onPageHide')
  }

  aboutToDisappear(): void {
    console.debug('===父-aboutToDisappear')
  }

  build() {
    Column({
      space: 10
    }) {
      Text(`Parent：${this.num}`)
        .fontColor(Color.Red)
        .fontSize(20)
      ChildComponent({ num: this.num })
      Button('点击')
        .onClick(() => {
          this.num++
        })
    }.alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ChildComponent {
 @State num: number = 0

  aboutToAppear(): void {
    console.debug('===子-aboutToAppear')
  }

  onDidBuild(): void {
    console.debug('===子-onDidBuild')
  }
  aboutToDisappear(): void {
    console.debug('===子-aboutToDisappear')
  }

  onPageShow(): void {
    console.debug('===子-onPageShow')
  }

  onPageHide(): void {
    console.debug('===子-onPageHide')
  }

  build() {
    Text(`Child：${this.num}`)
      .fontSize(20)
      .fontColor(Color.Orange)
  }
}