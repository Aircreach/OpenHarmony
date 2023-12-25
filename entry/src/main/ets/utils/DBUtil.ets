import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common';
import { BusinessError } from '@ohos.base';

export default class DBUtils {
  private static context: common.UIAbilityContext
  private  static dbMap = new Map<string,relationalStore.RdbStore>()
  private static currentDB: string = ''

  public static init(context: common.UIAbilityContext) {
    DBUtils.context = context
  }

  public static createDb(dbName: string): Promise<relationalStore.RdbStore> {

    DBUtils.currentDB = dbName
    let context: common.UIAbilityContext = DBUtils.context
    return new Promise<relationalStore.RdbStore>((resolve, reject) => {
      if (!context || !dbName) {
        return
      }
      const STORE_CONFIG: relationalStore.StoreConfig = {
        name: dbName,
        securityLevel: 1
      }

      let rdb = DBUtils.dbMap.get(dbName)
      if (!rdb) {
        relationalStore.getRdbStore(context, STORE_CONFIG).then(rdbStore => {
          DBUtils.dbMap.set(dbName, rdbStore)
          resolve(rdbStore)
        })
        // relationalStore.getRdbStore(context, STORE_CONFIG, (err: BusinessError, store: relationalStore.RdbStore) => {
        //   success(store)
        //   if (err) {
        //     console.error(`Get RdbStore failed, code is ${err.code},message is ${err.message}`);
        //     return error(err)
        //   }
        // })
      } else {
        resolve(rdb)
      }
    })
  }

  public static getRDB(dbName?: string) {
    if (dbName == undefined) {
      return DBUtils.dbMap.get(DBUtils.currentDB)
    }
    return DBUtils.dbMap.get(dbName)
  }

  // public queryArray <T> (predicates: relationalStore.RdbPredicates, columns?: Array<string>): Promise<Array<T>> {
  //
  //   const rdb:relationalStore.RdbStore = DBUtils.dbMap.get(DBUtils.currentDB)
  //   rdb.query(predicates).then(resultSet => {
  //     if (resultSet.rowCount == 0){
  //       console.log('未查询到数据');
  //       return
  //     }
  //     resultSet.goToFirstRow()
  //     do {
  //       let id: number = resultSet.getLong(resultSet.getColumnIndex('userId'))
  //       let name: string = resultSet.getString(resultSet.getColumnIndex('userName'))
  //       console.log(id + '   ' + name)
  //     }
  //     while (resultSet.goToNextRow())
  //   })
  //   return
  // }

  // public static insertBatch <T> (data: Array<T>, tbName: string ){
  //
  //   // 获取连接 rdbStore
  //   const rdbStore:relationalStore.RdbStore = DBUtils.dbMap.get(DBUtils.currentDB)
  //   if (rdbStore == null || rdbStore == undefined) {
  //     console.error('RDB连接错误 || TBName错误');
  //     return
  //   }
  //
  //
  //   rdbStore.batchInsert(tbName, , (err, num) => {
  //     console.log('RDB操作: insert, success' + num)
  //   })
  //
  //
  //
  //
  // }


}