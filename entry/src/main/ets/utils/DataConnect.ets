// // export default class DataConnect {
// //   let context = getContext()
// // }
// import relationalStore from '@ohos.data.relationalStore'
// import UIAbility from '@ohos.app.ability.UIAbility'
//
// export default class DataConnect {
//   private rdbStore: relationalStore.RdbStore | null = null;
//   private tableName: string;
//   private sqlCreateTable: string;
//   private columns: Array<string>;
//
//   constructor(tableName: string, sqlCreateTable: string, columns: Array<string>) {
//     this.tableName = tableName;
//     this.sqlCreateTable = sqlCreateTable;
//     this.columns = columns;
//   }
//
//
//   getStore (callback: Function = () => {
//   }) {
//     if (!callback || typeof callback === 'undefined' || callback === undefined) {
//
//       return;
//     }
//     if (this.rdbStore !== null) {
//
//       callback();
//       return
//     }
//     let context: Context = getContext(this) as Context;
//     try {
//       relationalStore.getRdbStore(context, Rdb.STORE_CONFIG, (err, rdb) => {
//         if (err) {
//           console.log('error' + err.message);
//           return;
//         }
//         this.rdbStore = rdb;
//         this.rdbStore.executeSql(this.sqlCreateTable);
//
//         callback();
//       });
//     } catch (error) {
//       console.error(`promise getRawFileContent failed, error code: ${error.code}, message: ${error.message}.`)
//     }
//
//
//
//   }
//
//   insertData(data: relationalStore.ValuesBucket, callback: Function = () => {
//   }) {
//     if (!callback || typeof callback == 'undefined' || callback == undefined) {
//       return;
//     }
//     let resFlag: boolean = false;  // 用于记录插入是否成功的flag
//     const valueBucket: relationalStore.ValuesBucket = data;  // 存储键值对的类型，表示要插入到表中的数据行
//     if (this.rdbStore) {
//       this.rdbStore.insert(this.tableName, valueBucket, (err, ret) => {
//         if (err) {
//           callback(resFlag);
//           return;
//         }
//         callback(ret);
//       });
//     }
//   }
//
//   deleteData(predicates: relationalStore.RdbPredicates, callback: Function = () => {
//   }) {
//     if (!callback || typeof callback === 'undefined' || callback === undefined) {
//       return;
//     }
//     let resFlag: boolean = false;
//     if (this.rdbStore) {
//       this.rdbStore.delete(predicates, (err, ret) => {
//         if (err) {
//           callback(resFlag);
//           return;
//         }
//         callback(!resFlag);
//       });
//     }
//   }
//
//   updateData(predicates: relationalStore.RdbPredicates, data: relationalStore.ValuesBucket, callback: Function = () => {
//   }) {
//     if (!callback || typeof callback === 'undefined' || callback === undefined) {
//
//       return;
//     }
//     let resFlag: boolean = false;
//     const valueBucket: relationalStore.ValuesBucket = data;
//     if (this.rdbStore) {
//       this.rdbStore.update(valueBucket, predicates, (err, ret) => {
//         if (err) {
//           callback(resFlag);
//           return;
//         }
//         callback(!resFlag);
//       });
//     }
//   }
//
//   query(predicates: relationalStore.RdbPredicates, callback: Function = () => {
//   }) {
//     if (!callback || typeof callback === 'undefined' || callback === undefined) {
//
//       return;
//     }
//     if (this.rdbStore) {
//       this.rdbStore.query(predicates, this.columns, (err, resultSet) => {
//         if (err) {
//
//           return;
//         }
//         callback(resultSet);
//         resultSet.close();
//       });
//     }
//   }
//
// }
//
