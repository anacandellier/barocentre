import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-elements"
export default class extends Controller {
  static targets = ["element"]
  connect() {
    console.log(this.element);
    console.log(this.elementTargets)
  }

  toggle() {
    event.currentTarget.classList.toggle("active");
    console.log(event.currentTarget);
    this.elementTargets.forEach((element) => {
      element.classList.toggle("active");
    })
  }
}
