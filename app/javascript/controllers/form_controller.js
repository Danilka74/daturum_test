import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "questionForm" ];

  display() {
    this.questionFormTarget.classList.remove("hidden")
  }

  reset() {
    this.questionFormTarget.reset()
    this.questionFormTarget.classList.add("hidden")
  }
}
