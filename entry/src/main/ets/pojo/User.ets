export default class User {
  id : string|number
  name : string = ''

  constructor(id : string|number , name : string) {
    this.id = id
    this.name = name


  }
  toString() : string {
    return '{userId=' + this.id + ',userName=' + this.name + '}'
  }
}