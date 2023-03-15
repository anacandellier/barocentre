import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }
  static targets = ['wrapper', "address", 'longitude', 'latitude']

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      placeholder: 'Adresse'
    })
    this.geocoder.addTo(this.wrapperTarget)
    this.geocoder.on("result", this.#setInputValue.bind(this))
    this.geocoder.on("clear", this.#clearInputValue.bind(this))
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
    this.longitudeTarget.value = event.result.center[0]
    this.latitudeTarget.value = event.result.center[1]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }
}
