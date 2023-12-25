import relationalStore from '@ohos.data.relationalStore'
import router from '@ohos.router'
import ItemData from '../pojo/List_User'
import User from '../pojo/User'
import DBUtils from '../utils/DBUtil'
import TransferTo from '../utils/TransferTo'

@Preview
@Component
export default struct Chat {
  @State pcIsFlag: boolean = true
  @State isExpend: boolean = false
  @State service: User = new User(8, '服务')
  @State favourite: User = new User(10, '收藏')
  @State friendCircle: User = new User(4, '朋友圈')
  @State cardBag: User = new User(3, '卡包')
  @State friend1: User = new User(1, '张三')
  @State friend2: User = new User(2, '里斯')
  @State userArray: Array<User> = [this.service, this.favourite, this.friendCircle, this.cardBag, this.friend1, this.friend2]


  @Builder
  MyMenu(){
    Menu() {
      MenuItem({content: '发起群聊', startIcon: $r("app.media.msg")}).contentFontColor(Color.White)
      MenuItem({content: '添加朋友', startIcon: $r("app.media.newfriend")}).contentFontColor(Color.White)
      MenuItem({content: '扫一扫', startIcon: $r("app.media.qr")}).contentFontColor(Color.White)
      MenuItem({content: '收付款', startIcon: $r("app.media.money")}).contentFontColor(Color.White)
    }
      .backgroundColor('#ff60ecd3')
  }

  build() {
    Column() {
      Row() {
        Text('微信').fontSize(20).fontWeight(FontWeight.Medium).textAlign(TextAlign.End).width('50%')
        Image($r('app.media.list_user_service')).width(40).margin({left: 115})
        Image($r('app.media.list_user_service')).width(40).margin({left: 5})
          .bindMenu(this.MyMenu())


      }.width('100%').backgroundColor('#ffececec')
      if (this.pcIsFlag) {
        Row(){
          Image($r('app.media.list_user_service')).width(30).margin({left: 5})
          Text('Windows 微信已登陆, 手机通知已关闭')
        }.width('100%').colorBlend('#ffff1f1f').borderColor('#ffae8585')
      }

      Divider()
        .color('#ffa9a8a8')
        .strokeWidth(1)
        .margin({top: 10})

      Scroll() {
        List() {
          ForEach(this.userArray, (item: User, index) => {
            ListItem() {
              Column() {
                Row() {
                  Image($r('app.media.cat')).height(50).borderRadius(50)
                  Column() {
                    Text(item.name).textAlign(TextAlign.Start).width(300).margin({left: 10})
                    Text() {
                      Span('[128条]')
                      Span('欢迎可能都是你父母可能是个飓风等级').margin({left: 5})
                    }.fontSize(10).maxLines(1).textOverflow({overflow: TextOverflow.Ellipsis}).width(300).margin({left: 8})
                  }
                }
                .height(50)
                .backgroundColor('#ffffffff')
                Divider().strokeWidth(1).opacity(0.8).width('90%').margin({top: 5, left: 20, bottom: 5})
              }

            }
              .margin({bottom: 1})
              .onClick( () => {
                router.pushUrl({
                  url: 'pages/Msg',
                  params: {
                    name: item.name
                  }
                })
              })

          })
        }.margin({top: 15})
      }

    }
  }


}

