import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="event-subscription"
export default class extends Controller {
  static values = {
    eventId: Number,
    currentUserId: Number,
   }
  static targets = ["users", "trashcan"]
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "EventChannel", id: this.eventIdValue },
      { received: this.handleReceived.bind(this) }
    )
  }

  handleReceived(data) {
    if (data.event_user) { this.usersTarget.insertAdjacentHTML("afterbegin", data.event_user) }
    if (data.url && data.current_user_id != this.currentUserIdValue) { window.location.href = data.url }
  }
}
