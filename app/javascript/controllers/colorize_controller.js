import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "link", "text" ]

  highlight() {
    const correctionId = event.currentTarget.id

    this.textTargets.forEach( (text) => {
      if (text.id == correctionId) {
        text.classList.add('light')
      }
    })
  }

  cleanUp() {
    const correctionId = event.currentTarget.id

    this.textTargets.forEach( (text) => {
      if (text.id == correctionId) {
        text.classList.remove('light')
      }
    })
  }

}
