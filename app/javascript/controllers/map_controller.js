// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static values = {
    apiKey: String,
    usermarkers: Array,
    bandmarkers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      projection: {
        name: "mercator"
      }
    });
    this.markerInstances = [];
    if (window.location.href.includes("user_search") || window.location.href.includes("users")){
      this.mapHasBandMarkers = false
    } else if (window.location.href.includes("band_search") || window.location.href.includes("bands")) {
      this.mapHasBandMarkers = true
    } else {
      this.mapHasBandMarkers = true
    }
    this.#addMarkersToMap(this.mapHasBandMarkers ? this.bandmarkersValue : this.usermarkersValue);
    this.#fitMapToMarkers();
  }
  #addMarkersToMap(markers) {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);
      const customMarker = document.createElement("div");
      customMarker.innerHTML = marker.marker_html;
      const markerInstance = new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map);
      this.markerInstances.push(markerInstance)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    if (this.mapHasBandMarkers) {
      this.bandmarkersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    }
    else {
      this.usermarkersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    }
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  toggleMarkers(){
    this.clearMarkers();
    const nextMarkers = this.mapHasBandMarkers ? this.usermarkersValue : this.bandmarkersValue;
    this.mapHasBandMarkers = !this.mapHasBandMarkers;
    this.#addMarkersToMap(nextMarkers);
    this.#fitMapToMarkers();
  }

  clearMarkers(){
    if (this.markerInstances.length > 0) {
      this.markerInstances.forEach(marker => marker.remove());
      this.markerInstances = [];
    }
  }
}
