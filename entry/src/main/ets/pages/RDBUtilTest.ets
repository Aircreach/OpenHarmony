import relationalStore from '@ohos.data.relationalStore'
import dataSharePredicates from '@ohos.data.dataSharePredicates'
import User from '../pojo/User'
import { rdbUtil } from '../utils/RDBUtil'

@Entry
@Component
struct RDBUtilTest {
  @State rdbName: string = ''
  @State sql: string = 'create table if not exists User(id integer primary key autoincrement,name text)'
  @State tableName: string = ''
  @State userId: string = ''
  @State userName: string = ''
  @State data: string = ''

  rdb: relationalStore.RdbStore | undefined = undefined

  build() {
    Column({space: 10}) {
      TextInput({placeholder: '输入RdbName', text: this.rdbName}).onChange((value) => {
        this.rdbName = value
      })
      TextInput({placeholder: '输入sql', text: this.sql}).onChange((value) => {
        this.sql = value
      })
      TextInput({placeholder: '输入TableName', text: this.tableName}).onChange((value) => {
        this.tableName = value
      })
      TextInput({placeholder: '输入id', text: this.userId}).onChange((value) => {
        this.userId = value
      })
      TextInput({placeholder: '输入name', text: this.userName}).onChange((value) => {
        this.userName = value
      })
      Text(this.data)
      Row({space: 5}) {
        Button('createRdb').onClick(async () => {
          this.rdb = await rdbUtil.createRDB(this.rdbName)
        })
        Button('建表').onClick(() => {
          if (this.rdb) {
            this.rdb.executeSql(this.sql)
          }

        })
        Button('getConnection').onClick(() => {
          rdbUtil.getConnection(this.rdbName)
        })
      }
      Row({space: 5}) {
        Button('插入User数据').onClick(() => {
          let user: User = new User(this.userId, this.userName)
          rdbUtil.insert<User>(this.tableName, user)
        })
        Button('查询所有').onClick(() => {
          let p: relationalStore.RdbPredicates = new relationalStore.RdbPredicates(this.tableName)
          rdbUtil.queryArray <User> (p)
        })
        Button('修改ById').onClick(() => {
          let user: User = new User(this.userId, this.userName)
          rdbUtil.updateById <User> (user, this.tableName, this.userId)
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}