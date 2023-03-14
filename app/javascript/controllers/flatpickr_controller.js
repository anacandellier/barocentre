import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ 'dateInput' ]

  connect() {
    this.fp = flatpickr(this.dateInputTarget, {
      minDate: new Date().setMinutes((Math.floor(new Date().getMinutes() / 15) + 1) * 15),
      enableTime: true,
      time_24hr: true,
      minuteIncrement: 15,
      disableMobile: true,
      inline: true,
      // onReady: () => {
      //   document.querySelector('.flatpickr-hour').setAttribute('readonly', true)
      //   document.querySelector('.flatpickr-minute').setAttribute('readonly', true)
      // } c'est pour empecher le clavier de s'ouvrir quand on clique sur les heures
    })


  }
}
