
import router from '@ohos.router'
import curves from '@ohos.curves'
import notificationManager from '@ohos.notificationManager'
import notification from '@ohos.notification'
import Notification from '@system.notification'
import { BusinessError } from '@ohos.base'
import call from '@ohos.telephony.call'

let phoneNumber: string
let password: string

@Entry
@Component
struct Login {

  @State flag: boolean = true
  @State translateY1: number = 0
  @State translateY2: number = 0

  @Builder
  mytext() {
    Text('ndsnfj')
  }

  onPageShow() {
    if (!this.flag) {
      this.flag = true
    }

  }

  build() {

    Scroll() {

      Column() {


        if (this.flag) {
          Stack() {
            Video({ src: ($rawfile('login.mp4')) })
              .width('100%')
              .height(250)
              .controls(false)
              .autoPlay(true)
              .loop(true)
            Column() {
              Text('WeChat')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#ff00f1cd')
                .textShadow({ radius: 7, color: '#ffe70505' })
                .textAlign(TextAlign.Center)
                .width('100%')

              Text('请登陆你的账号')
                .fontSize(14)
                .fontColor('#ff9d9d9d')
                .letterSpacing(2)
                .margin({ top: '1%' })
            }
          }
          Divider()
            .color('#ff7e7a7a')
            .strokeWidth(2)

          Row() {
            Text('Phone : ')
              .width('25%')

            TextInput({ placeholder: '请输入 PhoneNumber', text: '15162911056'})
              .placeholderFont({ size: 12 })
              .placeholderColor('#ff9d9d9d')
              .type(InputType.PhoneNumber)
              .width('75%')
              .onChange((data) => {
                phoneNumber = data
              })

          }
            .margin({ left: '5%', right: '5%', top: '2%' })
            .translate({y: this.translateY1})

          Row() {
            Text('Password : ')
              .width('25%')

            TextInput({ placeholder: '请输入 Password', text: '123456789'})
              .placeholderFont({ size: 12 })
              .placeholderColor('#ff9d9d9d')
              .type(InputType.Password)
              .width('75%')
              .onChange((data) => {
                password = data
              })

          }
            .margin({ left: '5%', right: '5%', top: '2%' })
            .translate({y: this.translateY2})

          Column() {
            Text('上述手机号仅用于登录验证')
              .fontSize(14)
              .fontColor('#ff9d9d9d')
              .letterSpacing(2)
              .margin({top: '65%'})
            // .position({x: '25%', y: '75%'})

            Button('同意并继续', { type: ButtonType.Normal })
              .backgroundColor('#ff22c8b5')
              .margin({top: '5%'})
                // .position({x: '35%', y: '78%'})
              .onClick(() => {
                if (phoneNumber != undefined && password != undefined) {
                  this.translateY1 = 1
                  this.translateY2 = -1
                  animateTo({duration: 1000, curve: curves.springCurve(400, 1, 1, 1.2)}, () => {
                    this.translateY1 = -2
                    this.translateY2 = 2
                    this.flag = !this.flag

                    setTimeout(() => {
                      router.pushUrl({
                        url: 'pages/Main',
                        params: {
                          phoneNumber: phoneNumber,
                          password: password
                        }
                      })
                    }, 1000)

                  })

                } else {
                  AlertDialog.show({
                    title: 'Error',
                    message: '请输入 phone 或 pwd',
                    autoCancel: true,
                    primaryButton: {
                      value: '确定',
                      action: () => {
                      }
                    },
                    gridCount: 4,
                    alignment: DialogAlignment.Center,
                  })
                  this.flag = !this.flag
                }
              })

          }.margin({bottom: '10%'})
        } else {

          Video({ src: ($rawfile('loading.mp4')), currentProgressRate: PlaybackSpeed.Speed_Forward_1_00_X})
            .width('100%')
            .height(250)
            .controls(false)
            .autoPlay(true)
            .loop(true)


        }

      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }
}