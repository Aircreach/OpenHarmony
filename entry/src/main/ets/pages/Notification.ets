import notificationManager from '@ohos.notificationManager';
import { BusinessError } from '@ohos.base';


// 通知 => 需要申请 NOTIFICATION_CONTROLLER 权限

@Entry
@Component
struct Notification {
  @State message: string = 'Hello World'

  aboutToAppear() {
    notificationManager.requestEnableNotification().then(() => {
      console.info(`[ANS] requestEnableNotification success`);
      let notificationRequest: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT, // 长文本类型通知
          longText: {
            title: 'test_title',
            text: 'test_text',
            additionalText: 'test_additionalText',
            longText: 'test_longText',
            briefText: 'test_briefText',
            expandedTitle: 'test_expandedTitle',
          }
        }
      };

      // 发布通知
      notificationManager.publish(notificationRequest, (err: BusinessError) => {
        if (err) {
          console.error(`Failed to publish notification. Code is ${err.code}, message is ${err.message}`);
          return;
        }
        console.info('Succeeded in publishing notification.');
      })
    }).catch((err: BusinessError) => {
      console.error(`[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
    })
  }

  build() {
    Row() {
      Column() {

        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}