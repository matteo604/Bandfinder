// app/javascript/controllers/toggle_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleSwitch", "hiddenArea", "filter", "userCard", "bandCard", "mapContainer", "toggleMarkers", "bandForm","userForm"];

  toggleContent() {
    this.toggleMarkersTarget.click();
    if (this.toggleSwitchTarget.checked) {
      this.userFormTarget.classList.remove("d-none");
      this.userCardTarget.classList.remove("d-none");
      this.bandFormTarget.classList.add("d-none");
      this.bandCardTarget.classList.add("d-none");
     } else {
      this.bandFormTarget.classList.remove("d-none");
      this.bandCardTarget.classList.remove("d-none");
      this.userFormTarget.classList.add("d-none");
      this.userCardTarget.classList.add("d-none");
     }
  }
}
