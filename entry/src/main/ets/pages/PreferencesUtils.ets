import { preferencesUtil } from '../utils/PreferencesUtil'

@Entry
@Component
struct test {
  @State myKey: string = ''
  @State myValue: string = ''
  @State getKey: string = ''
  @State preName: string = ''
  @State flag: boolean = false
  aboutToAppear() {
  }

  build() {
    Column({space: 10}) {
      Row({space: 5}) {
        TextInput({placeholder: '请输入PreferenceName',text: this.preName}).width('80%').onChange((value) => {
          this.preName = value
        })
        Toggle({ type: ToggleType.Switch, isOn: this.flag })
          .selectedColor('#007DFF')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.flag = isOn
          })
      }.width('80%').margin({top: 20})

      TextInput({text: this.myKey}).onChange((value) => {
        this.myKey = value
      }).width('80%')
      TextInput({text: this.myValue}).onChange((value) => {
        this.myValue = value
      }).width('80%')

      Button('init').onClick(() => {
        preferencesUtil.init(getContext())
      })
      Button('添加').onClick(() => {
        preferencesUtil.putPreference(this.myKey, this.myValue, this.preName, this.flag)
        this.getKey = this.myKey
        this.myKey = ''
        this.myValue = ''
      })
      TextInput({text: this.getKey}).onChange((value) => {
        this.getKey = value
      }).width('80%')
      Row({space: 5}) {
        Button('查询').onClick(() => {
          preferencesUtil.getPreference(this.getKey, this.preName)
        })
        Button('删除').onClick(() => {
          preferencesUtil.delPreference(this.getKey, this.flag, this.preName)
        })
      }
      Row() {
        Button('查询全部').onClick(() => {
          preferencesUtil.getAllPreferences<string>((arr: string[]) => {}, this.preName)

        }).linearGradient({
          direction: GradientDirection.RightTop,
          colors: [[Color.Red, 0], [Color.Yellow, 0.7], [Color.Black, 1]]
        })
        Button('查询全部Keys').onClick(() => {
          preferencesUtil.getAllKeys(() => {}, this.preName)

        }).linearGradient({
          direction: GradientDirection.RightTop,
          colors: [[Color.Red, 0], [Color.Yellow, 0.7], [Color.Black, 1]]
        })
        Button('删除全部').onClick(() => {
          preferencesUtil.delAllPreferences(this.flag, this.preName)
        })
      }

    }.width('90%')

  }
}