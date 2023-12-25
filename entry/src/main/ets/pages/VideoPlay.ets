@Entry
@Component
struct VideoPlay {
  @State process: number = 0
  @State duration: number = 0
  controller: VideoController = new VideoController()

  build() {
    Column() {
      Video({src: $rawfile('loading.mp4'),previewUri: $r('app.media.cat'), controller: this.controller})
        .width('100%')
        .height(300)
        .onPrepared((event) => {
          this.duration = event.duration
        })
        .onUpdate((event) => {
          this.process = event.time
        })
      Slider({value: this.process, max: this.duration}).onChange((value:number) => {
        this.controller.setCurrentTime(value)
        this.controller.start()
      })
    }
  }


}

