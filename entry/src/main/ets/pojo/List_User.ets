export default class ItemData {
  title : string
  img : string
  others : number = 0

  constructor(title : string , img : string , others : number) {
    this.title = title
    this.img = img
    this.others = others

  }
}
