import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

export default class extends Controller {
  static targets = [ "link", 'loader', 'map' ]
  connect() {
    console.log(this.loaderTarget)
  }

  fire(event) {
    event.preventDefault()

    Swal.fire({
      title: 'Prêt à trouver le BarOCentre ?',
      text: this.messageValue,
      icon: 'question',
      confirmButtonText: 'Confirmer',
      showCancelButton: true,
      cancelButtonText: 'Annuler'
    }).then((result) => {
      if (result.isConfirmed) {
        this.loaderTarget.classList.remove('d-none')
        this.mapTarget.classList.add('d-none')
        setTimeout(() => {
          this.linkTarget.click()
        }, 1500);
      }
    })
  }
}
