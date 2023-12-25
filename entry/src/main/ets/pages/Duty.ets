import font from '@ohos.font'
import relationalStore from '@ohos.data.relationalStore'
import Task from '../pojo/Task'
import DBUtils from '../utils/DBUtil'

@Entry
@Component
struct Duty {
  rdb: Promise<relationalStore.RdbStore> = DBUtils.createDb('Task')
  @Provide arr: Task[] = []
  @State isExpend: boolean[] = []


  dialogController: CustomDialogController = new CustomDialogController({
    builder: TaskDialog()
  })

  @Builder taskListItem_Menu(index: number) {
    Row() {
      Image($r('app.media.edit03')).width(20).onClick(() => {
        console.log(index.toString());
        console.log(JSON.stringify(this.arr[index]));
        let dialogController2: CustomDialogController = new CustomDialogController({
          builder: TaskDialog({
            taskDialogController: this.dialogController,
            flag: false,
            isExpand: true,
            dialogSize: 1200,
            index: index,
            title: this.arr[index].title,
            content: this.arr[index].content,
            date: this.arr[index].date
          })
        })
        dialogController2.open()
      })
      Image($r('app.media.delete02')).width(20).onClick(() => {
        this.arr.splice(index, 1)
      })
    }.width(50)
  }

  build() {
    Column() {
      Row() {
        Text('任务进度:').fontSize(30).fontFamily('02')
        MyProgress().margin({right: 40})
      }.width('90%').justifyContent(FlexAlign.SpaceBetween).margin({top: 20})

      Divider().strokeWidth(1).color('#ff0747d0').margin({top: 20})
      Row() {
        Button('添加任务')
          .onClick(() => {
            this.dialogController.open()
          })

        Image($r('app.media.setting01')).width(25).margin({left: 150})


      }.width('90%').margin({top: 20})


      List({space: 10}) {
        ForEach(this.arr, (item: Task, index: number) => {
          ListItem() {
            TaskListItem({task: this.arr[index]})
          }.swipeAction({
            start: {
              builder: this.taskListItem_Menu(index)
            }
          })
        })
      }.width('90%').margin({top: 20})


    }.width('100%')
  }

  aboutToAppear() {
    font.registerFont({
      familyName: '01',
      familySrc: $rawfile('font/media.ttf')
    })

    font.registerFont({
      familyName: '02',
      familySrc: $rawfile('font/02.ttf')
    })
  }
  // aboutToDisappear() {
  //   this.dialogController = null
  // }
}

@Component
struct MyProgress {

  @Consume arr: Task[]

  getProgress(arr: Task[]) : number {
    let num: number = 0
    for (let item of this.arr) {
      if (item.state) {
        num++
      }
    }
    return num
  }

  build() {

    Stack() {
      Progress({value: this.getProgress(this.arr), total: this.arr.length, type: ProgressType.Ring})
        .width(100)
        .color('#ff27efc6')
        .backgroundColor('#ff65ffaa')
        .style({status: ProgressStatus.PROGRESSING, enableSmoothEffect: true})

      Text() {
        Span(this.getProgress(this.arr).toString())
        Span('/')
        Span(this.arr.length.toString())
      }.fontSize(25)
    }
  }
}

@CustomDialog
struct TaskDialog {
  @State dialogSize: number = 200
  @State isExpand: boolean = false
  @State flag: boolean = true
  @Consume arr: Task[]
  aboutToDisappear() {
    // this.taskDialogController = null
    console.log('dialog 销毁')
  }


  taskDialogController: CustomDialogController
  index: number = 0
  title: string = ''
  content: string = ''
  date: Date = new Date()

  build() {
    Column() {
      Row() {
        Image($r('app.media.expand01'))
          .width(15)
          .position({x: 140, y:  10})
          .onClick(() => {
            if (this.isExpand) {
              animateTo({ duration: 500, curve: Curve.Linear }, () => {
                this.dialogSize = 200
              })
              this.isExpand = !this.isExpand
            } else {
              animateTo({ duration: 500, curve: Curve.Linear }, () => {
                this.dialogSize = 1200
              })
              this.isExpand = !this.isExpand
            }
          })
      }.height(20)

      if (this.isExpand) {
        TextInput({text: this.title, placeholder: '请输入标题'}).height('5%').width('90%').margin({top: '3%'})
          .onChange((value: string) => {
            this.title = value
            console.log(this.title)
          })
      }

      TextArea({text: this.content, placeholder: '请输入任务内容'}).height('30%').width('90%').margin({top: '3%'})
        .onChange((value: string) => {
          this.content = value
          console.log(this.content)
        })
      if (this.isExpand)  {
        Button('设置提醒日期', {type: ButtonType.Normal}).height(40).margin({top: 20}).backgroundColor('#ff48cdc1').onClick(() => {
          DatePickerDialog.show({
            start: new Date("2000-1-1"),
            end: new Date("2100-12-31"),
            selected: this.date,
            showTime:true,
            useMilitaryTime:false,
            disappearTextStyle: {color: Color.Pink, font: {size: '22fp', weight: FontWeight.Bold}},
            textStyle: {color: '#ff00ff00', font: {size: '18fp', weight: FontWeight.Normal}},
            selectedTextStyle: {color: '#ff182431', font: {size: '14fp', weight: FontWeight.Regular}},
            onDateAccept: (date: Date) => {
              this.date = date
              console.log(this.date.toString());
            }
          })
        })
      }

      Row() {
        Button('cancel').onClick(() => {
          AlertDialog.show({
            title: '警告',
            message: '取消将丢失所有内容',
            autoCancel: false,
            alignment: DialogAlignment.Center,
            primaryButton: {
              value: '取消',
              action: () => {}
            },
            secondaryButton: {
              value: '确认',
              action: () => {
                this.taskDialogController.close()
              }
            }
          })
        })
        Button('confirm').onClick(() => {

          let task: Task
          task = this.isExpand ? new Task(this.title, this.content, this.date) : new Task('Task未命名' , this.content, new Date())
          console.log('=====',this.date.toLocaleString());
          console.log('=======',JSON.stringify(task))
          if (this.flag) {
            this.arr.push(task)
          } else {
            this.arr[this.index] = task
          }
          console.log('=======1')
          this.taskDialogController.close()
          console.log('=======2')
        })
      }
      .width('80%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top: 15})
    }
    .height(this.dialogSize)

  }
}

@Component
struct TaskListItem {

  @ObjectLink task: Task
  build() {
    Column() {
      Row() {
        Text(this.task.title).fontSize(20).fontWeight(FontWeight.Bold).maxLines(1).width('90%')
        Image($r('app.media.expand02')).width(20).rotate({angle: this.task.isExpand ? 0 : -90}).margin({left: 10})
          .onClick(() => {

            this.task.isExpand = !this.task.isExpand

          })
      }

      if (this.task.isExpand) {
        Text(this.task.content).fontSize(16).fontStyle(FontStyle.Italic).fontFamily('鸿雷拙书简体').width('90%').margin({top: 5})
        Text(this.task.date.toLocaleString()).fontColor('#ff835ff5').margin({left: 100, top: 10})
      }
      Divider().strokeWidth(1).width('80%').margin({top: 12})
    }
  }
}



