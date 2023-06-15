import { Controller } from "@hotwired/stimulus"
// import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    markersrestaurants: Array,
    center: Array

  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const customMarker = document.createElement("div")
      if (marker.type === "Restaurant") {
        customMarker.innerHTML = marker.food_marker_html
      } else if (marker.type === "Hotel") {
        customMarker.innerHTML = marker.hotel_marker_html
      } else if (marker.type === "Attraction") {
        customMarker.innerHTML = marker.attr_marker_html
      }
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)

    })

    // this.markersrestaurantsValue.forEach((marker) => {
    //   console.log(marker)
    //   const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
    //   new mapboxgl.Marker()
    //     .setLngLat([ marker.lng, marker.lat ])
    //     .setPopup(popup)
    //     .addTo(this.map)
    // })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 100, maxZoom: 13, duration: 5 })
  }
}
