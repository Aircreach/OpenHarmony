import fs from '@ohos.file.fs';
import FileManager from '../utils/FileManager';
import common from '@ohos.app.ability.common';
import buffer from '@ohos.buffer';
import DBUtils from '../utils/DBUtil';
import User from '../pojo/User';
import { ValuesBucket } from '@ohos.data.ValuesBucket';
import TransferTo from '../utils/TransferTo';
import relationalStore from '@ohos.data.relationalStore';

@Entry
@Component
struct WebComponent {
  @State rawFileName: string = '1.json'
  @State readFileName: string = '1.json'
  @State createFileName: string = 'test.txt'
  dbName: string = 'myapp.db'
  rdb: Promise<relationalStore.RdbStore> = DBUtils.createDb(this.dbName)

  // webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  aboutToAppear() {
    this.rdb.then((rdb: relationalStore.RdbStore) => {
      if (rdb != null || rdb != undefined) {
        console.log('成功');
      }
      rdb.executeSql("create table if not exists User(id integer primary key autoincrement,name text)")
    })
  }
  build() {
    Column() {
      Row() {
        TextInput({placeholder: '请输入读取的文件', text: this.rawFileName}).onChange((text: string) => {
          this.rawFileName = text
          this.readFileName = text
        })
        Button('Copy').onClick(() => {
          FileManager.rawfileToSandbox(this.rawFileName)
        })
      }.width('80%').justifyContent(FlexAlign.SpaceBetween).margin({top: 40})

      Row() {
        TextInput({placeholder: '请输入读取的文件',text: this.readFileName}).onChange((text: string) => {
          this.readFileName = text
        })
        Button('Read').onClick(() => {
          FileManager.getFileFromSB(this.readFileName, () => {
            console.log('================');
          })
        })
      }.width('80%').justifyContent(FlexAlign.SpaceBetween).margin({top: 40})


      Row() {
        TextInput({placeholder: '请输入创建的文件'}).onChange((text: string) => {
          this.createFileName = text
        })
        Button('Create AND Write').onClick(() => {
          let context = getContext(this) as common.UIAbilityContext;
          let filesDir = context.filesDir;

          // 新建并打开文件
          let file = fs.openSync(filesDir + '/' + this.createFileName, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
          // 写入一段内容至文件
          let writeLen = fs.writeSync(file.fd, "个别月份合适不恩极为愤慨和内疚");
          console.info("The length of str is: " + writeLen);
          // 从文件读取一段内容
          let arrayBuffer = new ArrayBuffer(1024);
          class Option {
            public offset: number = 0;
            public length: number = 0;
          }
          let option = new Option();
          option.length = arrayBuffer.byteLength;
          let readLen = fs.readSync(file.fd, arrayBuffer, option);
          let buf = buffer.from(arrayBuffer, 0, readLen);
          console.info("the content of file: " + buf.toString());
          // 关闭文件
          fs.closeSync(file);

        })
      }.width('80%').justifyContent(FlexAlign.SpaceBetween).margin({top: 40})
      Button('RDB INSERT').onClick(() => {

        let arr: Array<User>
        let service: User = new User(8, '服务')
        let favourite: User = new User(10, '收藏')
        let friendCircle: User = new User(4, '朋友圈')
        let cardBag: User = new User(3, '卡包')
        let friend1: User = new User(1, '张三')
        let  friend2: User = new User(2, '里斯')
        let userArray: Array<User> = [service, favourite, friendCircle, cardBag, friend1, friend2]
        let valueBuckets: ValuesBucket[] = TransferTo.array2ValueBucket<User>(userArray)

        this.rdb.then((rdb: relationalStore.RdbStore) => {


          TransferTo.json2Arr<User>('list_user_data.json').then((array) => {
            arr = array
            console.log(JSON.stringify(arr));
          })
          rdb.insert('User', {
            id: 155,
            name: '李寻欢'
          })
          rdb.insert('User', {
            id: 123,
            name: '你好'
          })
          rdb.insert('User', {
            id: 110,
            name: '???'
          })
          rdb.batchInsert('User', valueBuckets).then((num) => {
            console.log('[DBUTIl] BATCHINSERT: ' + num);
          })

          })
        })

      Button('RDB QUERY').onClick(() => {
        this.rdb.then((rdb) => {

          let predicates = new relationalStore.RdbPredicates('User')
          // predicates.equalTo('userId' , 1)
          rdb.query(predicates).then(resultSet => {
            if (resultSet.rowCount == 0) {
              console.log('未查询到数据');
              return
            }
            // for (let user of arr2) {
            //   console.log(user.toString());
            // }
            resultSet.goToFirstRow()
            do {
              let index: number = resultSet.getColumnIndex('id')
              let id: number = resultSet.getLong(index)
              // let uArr: Uint8Array = resultSet.getBlob(index)
              // let id2: string = TransferTo.uint8ArrayToString(uArr)
              // console.log(id2);
              let name: string = resultSet.getString(resultSet.getColumnIndex('name'))
              console.log(id + '   ' + name)
            } while (resultSet.goToNextRow())
            // let arr: User[] = TransferTo.resultSet2Array<User>(resultSet)
            // console.log(arr.length.toString());
            // console.log(arr.toString());

            resultSet.close()
            console.log('complete');

          })


        })
      })
    }
  }
}
