import router from '@ohos.router'
import List_User from '../pojo/List_User'
import ItemData from '../pojo/List_User'
import TransferTo from '../utils/TransferTo'

let itemArr: Array<List_User> = []
TransferTo.json2Arr<List_User>('data_mine_list_item.json').then((array) => {
  itemArr = array
  // console.log(JSON.stringify(itemArr));
})

@Preview
@Component
export default struct Mine {
  @State message: string = 'Hello World'
  @State color: string = '#FF9B9B9B'
  @State imgPath: string = 'app.media.list_user_service'
  // @State service: ItemData = new ItemData('服务', $r('app.media.list_user_service'), 1)
  // @State favourite: ItemData = new ItemData('收藏', $r('app.media.list_user_service'), 0)
  // @State friendCircle: ItemData = new ItemData('朋友圈', $r('app.media.list_user_service'), 0)
  // @State cardBag: ItemData = new ItemData('卡包', $r('app.media.list_user_service'), 0)
  // @State expression: ItemData = new ItemData('表情', $r('app.media.list_user_service'), 1)
  // @State settings: ItemData = new ItemData('设置', $r('app.media.list_user_service'), 0)


  aboutToShow() {



  }

  build() {
    Column() {
      Row({ space: 10 }) {
        Image($r('app.media.list_user_service'))
          .width(75)
          .margin({ left: 0 })
          .borderWidth(1)
          .border({width: 1 , color: this.color})
          .onClick(() => {
            router.pushUrl({
              url: 'page/service',
              params: 'service'
            })
          })
        Column() {
          Text('凛梓')
            .fontSize(25)
            .maxLines(1)
            .textAlign(TextAlign.Start)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Text('微信号: ' + '15162911056')
            .maxLines(1)
            .textAlign(TextAlign.Start)
            .fontColor('#ff515151')
            .width('100%')
        }
      }
        .margin({top : 10})

      Divider()
        .strokeWidth(10)
        .color(this.color)
        .margin({top: 5})

      List() {
        ForEach(itemArr, (item: ItemData) => {

          ListItem() {
            Row() {
              Row() {
                Image($r('app.media.list_user_service'))
                  .width(30)

                Text(`${item.title}`)
              }

              Image($r(item.img))
                .width(30)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
          }

          if (item.others == 1) {
            ListItem() {
              Row() {
                Divider()
                  .width('100%')
                  .strokeWidth(5)
                  .color(this.color)
              }
            }
          }
        })
      }
    }

    // Row({space : 1}) {
    //
    //   Image($r('app.media.list_user_service'))
    //     .width(30)
    //   Text(`${this.arrUser[0]}`)
    //
    // }

  }
}