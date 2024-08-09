@Component
export struct CustomToggle {
  @Link isOpen: boolean
  text: string = ''

  build() {
    Row({ space: 10}) {
      Text(this.text).fontSize(14).fontColor(Color.Black)
      Toggle({ type: ToggleType.Switch, isOn: this.isOpen })
        .onChange((isOn: boolean) => {
          this.isOpen = isOn
        })
        .selectedColor('#00ff00')
        .switchPointColor(Color.Red)
    }.alignItems(VerticalAlign.Center)
  }
}