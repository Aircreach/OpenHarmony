import web_webview from '@ohos.web.webview'
import business_error from '@ohos.base'
import webview from '@ohos.web.webview'

@Entry
@Component
struct Ads {
  webviewController: webview.WebviewController = new webview.WebviewController

  @State message: string = 'Hello World'




  build() {
    Row() {
      Column() {
        Button('点击').onClick( () => {

        })

        Button('loadUrl')
          .onClick(() => {
            try {
              // 点击按钮时，通过loadUrl，跳转到www.example1.com
              this.webviewController.loadUrl('www.example1.com');
            } catch (error) {
              let e: business_error.BusinessError = error as business_error.BusinessError;
              console.error(`ErrorCode: ${e.code},  Message: ${e.message}`);

            }
          })

        Web({ src: 'www.example.com', controller: this.webviewController}).height('80%')
      }
      .width('100%')
    }
    .height('100%')
  }
}

@CustomDialog
struct CustomDialogExampleTwo {
  controllerTwo?: CustomDialogController

  build() {
    Column() {
      Text('我是第二个弹窗')
        .fontSize(30)
        .height(100)
      Button('点我关闭第二个弹窗')
        .onClick(() => {
          if (this.controllerTwo != undefined) {
            this.controllerTwo.close()
          }
        })
        .margin(20)


    }
  }


}

// @CustomDialog
// struct CustomDialogExample {
//   @Link textValue: string
//   @Link inputValue: string
//   dialogControllerTwo: CustomDialogController | null = new CustomDialogController({
//     builder: CustomDialogExampleTwo(),
//     alignment: DialogAlignment.Bottom,
//     offset: { dx: 0, dy: -25 } })
//   controller?: CustomDialogController
//   // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在所有controller的后面
//   cancel: () => void = () => {
//   }
//   confirm: () => void = () => {
//   }
// }