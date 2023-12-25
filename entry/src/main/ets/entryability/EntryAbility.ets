import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';

import relationalStore from '@ohos.data.relationalStore';
import User from '../pojo/User';
import FileManager from '../utils/FileManager';
import PreferencesUtils from '../pages/PreferencesUtils';
import TransferTo from '../utils/TransferTo';
import DBUtils from '../utils/DBUtil';
import { ValuesBucket } from '@ohos.data.ValuesBucket';


export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');




    // 通知, 使能通知开关
    // notificationManager.requestEnableNotification().then(() => {
    //   console.info(`[ANS] requestEnableNotification success`);
    // }).catch((err: BusinessError) => {
    //   console.error(`[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
    // });
    // let notificationRequest: notificationManager.NotificationRequest = {
    //   id: 1,
    //   content: {
    //     contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
    //     normal: {
    //       title: 'test_title',
    //       text: 'test_text',
    //       additionalText: 'test_additionalText',
    //     }
    //   }
    // };
    // notificationManager.publish(notificationRequest, (err:BusinessError) => {
    //   if (err) {
    //     console.error(`Failed to publish notification. Code is ${err.code}, message is ${err.message}`);
    //     return;
    //   }
    //   console.info('Succeeded in publishing notification.');
    // });

    // RDB数据库
    DBUtils.init(this.context)
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    FileManager.init(this.context)

    // PreferencesUtil.init(this.context)

    // let filesDir: string = this.context.filesDir
    // let file: fs.File = fs.openSync(filesDir + 'test.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
    //
    // // 写入一段内容至文件
    // let writeLen = fs.writeSync(file.fd, "Try to write str.");
    // console.info("The length of str is: " + writeLen);
    // // 从文件读取一段内容
    // let arrayBuffer = new ArrayBuffer(1024);
    // class Option {
    //   public offset: number = 0;
    //   public length: number = 0;
    // }
    // let option = new Option();
    // option.length = arrayBuffer.byteLength;
    // let readLen: number = fs.readSync(file.fd, arrayBuffer, option)
    // let buf: buffer.Buffer = buffer.from(arrayBuffer, 0, readLen)
    // console.info("the content of file: " + buf.toString())
    // // 关闭文件
    // fs.closeSync(file);

    windowStage.loadContent('utils/PreferencesUtil', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });





  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
