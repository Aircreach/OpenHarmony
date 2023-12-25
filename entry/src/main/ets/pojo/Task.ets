@Observed
export default class ItemData {
  title: string
  content: string
  date: Date
  state: boolean = false
  isExpand: boolean = false
  constructor(title : string , content : string , date : Date, state ?: boolean) {
    this.title = title
    this.content = content
    this.date = date
    if (state != undefined) {
      this.state = state
    }
  }
}