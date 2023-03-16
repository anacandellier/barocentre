import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="event-subscription"
export default class extends Controller {
  static values = {
    eventId: Number,
    currentUserId: Number,
   }
  static targets = ["users", "trashcan", "barCard"]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "EventChannel", id: this.eventIdValue },
      { received: this.handleReceived.bind(this) }
    )
  }

  handleReceived(data) {
    if (data.event_user) { this.usersTarget.insertAdjacentHTML("afterbegin", data.event_user) }
    if (data.url && data.current_user_id != this.currentUserIdValue) { window.location.href = data.url }
    if (data.bar_card) {
      const barCard = this.barCardTargets.find(e => e.dataset.id == data.bar_id)
      barCard.outerHTML = data.bar_card
    }
    if (data.most_voted_bars_ids) {
      this.barCardTargets.forEach((barCard) => { barCard.classList.remove('card-bar-voted') })
      data.most_voted_bars_ids.forEach((barId) => {
        const barCard = this.barCardTargets.find(e => e.dataset.id == barId)
        barCard.classList.add('card-bar-voted')
      })
    }
  }
}
