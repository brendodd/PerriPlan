import { Controller } from "@hotwired/stimulus"
// import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
   restaurants_geocoding
    markersrestaurants: Array
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
      let color = '#000'
      if (marker.type === "Restaurant") {
        color = '#581845'
      } else if (marker.type === "Hotel") {
        color = '#FFC300'
      } else if (marker.type === "Attraction") {
        color = '#DAF7A6'
      }
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      new mapboxgl.Marker({color: color})
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
