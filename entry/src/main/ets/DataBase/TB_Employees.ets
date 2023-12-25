import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import { BusinessError } from "@ohos.base";
import relationalStore from '@ohos.data.relationalStore';

let store: relationalStore.RdbStore | undefined = undefined;

export default class TB_Employees extends UIAbility {

  onWindowStageCreate(windowStage: window.WindowStage) {

    const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL, CODES BLOB)'
    const STORE_CONFIG: relationalStore.StoreConfig = {
      name: "RdbTest.db",
      securityLevel: relationalStore.SecurityLevel.S1
    };

    relationalStore.getRdbStore(this.context, STORE_CONFIG, (err: BusinessError, rdbStore: relationalStore.RdbStore) => {
      store = rdbStore;
      if (err) {
        console.error(`Get RdbStore failed, code is ${err.code},message is ${err.message}`);
        return;
      }
      console.info('Get RdbStore successfully.');
    })

    // 当数据库创建时，数据库默认版本为0
    if (store.version == 0) {
      store.executeSql(SQL_CREATE_TABLE); // 创建数据表
      // 设置数据库的版本，入参为大于0的整数
      store.version = 3;
    }

    // 如果数据库版本不为0且和当前数据库版本不匹配，需要进行升降级操作
    // 当数据库存在并假定版本为1时，例应用从某一版本升级到当前版本，数据库需要从1版本升级到2版本
    if (store.version != 3 && store.version == 1) {
      // version = 1：表结构：EMPLOYEE (NAME, SALARY, CODES, ADDRESS) => version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS)
      if (store != undefined) {
        (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE ADD COLUMN AGE INTEGER');
        store.version = 2;
      }
    }

    // 当数据库存在并假定版本为2时，例应用从某一版本升级到当前版本，数据库需要从2版本升级到3版本
    if (store.version != 3 && store.version == 2) {
      // version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS) => version = 3：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES)
      if (store != undefined) {
        (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE DROP COLUMN ADDRESS TEXT');
        store.version = 3;
      }
    }

    // 请确保获取到RdbStore实例后，再进行数据库的增、删、改、查等操作
  }


}
