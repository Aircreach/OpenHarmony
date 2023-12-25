import router from '@ohos.router'
import call from '@ohos.telephony.call'

@Entry
@Component
struct Msg {
  @State message: string = 'Hello World'
  @State name: string = (router.getParams() as Record<string, string>)['name']
  @State arr: string[] = ['你好', '黑白不分', '大家撒回复i的速度放缓hjbhjjkjkhnjkjjhn']

  build() {
    Column() {

      Column() {
        Row() {
          Image($r('app.media.return'))
            .width('8%')
            .onClick(() => {
              router.back()
            })
          Text(this.name)
            .fontSize('20')
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('84%')

          Image($r('app.media.app_icon')).width('8%').onClick(() => {
            call.makeCall('15162911056', () => {
              console.log('电话');
            })
          })
        }.backgroundColor('#ffececec')

        Scroll() {
          Column() {
            List({ space: 2 }) {
              ForEach(this.arr, (item: string, index) => {
                ListItem() {
                  Row() {
                    Image($r('app.media.cat')).width(40).margin({ top: 0, left: 0 })
                    Column() {
                      Text(this.name)
                        .fontSize(10)
                        .fontColor('#ff9d9d9d')
                        .width('82%')
                        .textAlign(TextAlign.Start)
                        .margin({ left: 2, bottom: 0.5 })
                      Text(item)
                        .fontSize(16)
                        .width('80%')
                        .margin({ top: 1, left: 2 })
                        .border({ width: 0.1, color: '#ffd7d7d7' })
                        .backgroundColor('#edffffff')
                        .borderRadius(5)
                    }
                  }
                }.margin({ bottom: 10 })
              })
            }
          }
          .width('100%')
          .height('100%')
        }
        .width('90%')
        .height('100%')
        .margin({top: 10})


      }
      .width('100%')
      .height('80%')
      .margin({ left: 5, top: 20, bottom: 20 })

      Row() {
        TextInput().width('80%')
        Button('发送')

      }
      .width('90%')
      .height(40)
      .margin({bottom: 5})
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#ffececec')

  }
}