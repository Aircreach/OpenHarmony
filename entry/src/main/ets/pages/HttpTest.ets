import relationalStore from '@ohos.data.relationalStore'
import { ValuesBucket } from '@ohos.data.ValuesBucket'
import http from '@ohos.net.http'
import User from '../pojo/User'
import DBUtils from '../utils/DBUtil'
import TransferTo from '../utils/TransferTo'
import Chat from './Chat'
import Mine from './Mine'



@Entry
@Component
struct Main {
  @State message: string = 'Hello World'
  @State poem: string = '把酒祝东风'
  @State from: string = '柳宗元'

  // private userTable = new UserTable();
  // @State service: ItemData = new ItemData('服务' , $r('app.media.list_user_service') , 1)
  // @State favourite: ItemData = new ItemData('收藏' , $r('app.media.list_user_service') , 0)
  // @State friendCircle: ItemData = new ItemData('朋友圈' , $r('app.media.list_user_service'), 0)
  // @State cardBag: ItemData = new ItemData('卡包' , $r('app.media.list_user_service'), 0)
  // @State expression: ItemData = new ItemData('表情' , $r('app.media.list_user_service') , 1)
  // @State settings: ItemData = new ItemData('设置' , $r('app.media.list_user_service') , 0)
  // @State arrUser: ItemData[] = [this.service , this.favourite , this.friendCircle , this.cardBag , this.expression , this.settings]

  @State pcIsFlag: boolean = true
  @State isExpend: boolean = false
  @State sts: st[] = []




  build() {
    Column() {
      Button('REQUEST').onClick(() => {
        let httpRequest: http.HttpRequest= http.createHttp()
        // httpRequest.request('https://api.apiopen.top/api/sentences', {method: http.RequestMethod.GET}, (err, data) => {
        //   if (!err) {
        //     this.poem = JSON.parse(`${data.result}`).result.name
        //     this.from = JSON.parse(`${data.result}`).result.from
        //     console.log(this.poem)
        //     console.log(this.from)
        //   }
        // })
        httpRequest.request('https://api.apiopen.top/api/sentences', {method: http.RequestMethod.GET}).then((data: http.HttpResponse) => {

          let s: st = JSON.parse(`${data.result}`).result
          console.log(JSON.stringify(s))
          this.sts.push(s)

        })
      })

      List({space: 10}) {
        ForEach(this.sts, (item: st, index: number) => {
          ListItem() {
            Row() {
              Text(item.from)
              Text(item.name)
            }
          }
        })
      }

    }
  }
}
class st {
  name: string
  from: string

  constructor(name: string, from: string) {
    this.name = name
    this.from = from
  }
}