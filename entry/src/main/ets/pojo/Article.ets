export default class Article {
  title: string
  author: string
  date: string
  content: string | Resource

  constructor(title: string, author: string, date: string, content: string | Resource) {
    this.title = title
    this.author = author
    this.date = date
    this.content = content
  }
}