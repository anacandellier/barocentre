import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {
  static values = {
    title: String,
    url: String,
  }

  share() {
    const sharingObj = {
      title: this.titleValue,
      text: `Hello, inscris toi à l'event : ${this.titleValue} en donnant ton adresse et ton moyen de transport pour qu'on trouve un bar qui arrange tout le monde`,
      url: this.urlValue
    }
    if (navigator.share) {
      navigator.share(sharingObj)
        .then(() => { console.log('Thanks for sharing!') })
        .catch(console.error);
    } else {
      console.log(sharingObj)
    }
  }
}
