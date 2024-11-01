// app/javascript/controllers/toggle_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleSwitch", "userCard", "bandCard", "toggleMarkers", "bandForm", "userForm", "slider", "status"];

  toggleContent() {
    this.toggleMarkersTarget.click();
    if (this.toggleSwitchTarget.checked) {
      this.statusTarget.value = "on"
      this.userFormTarget.classList.remove("d-none");
      this.userCardTarget.classList.remove("d-none");
      this.bandFormTarget.classList.add("d-none");
      this.bandCardTarget.classList.add("d-none");
     } else {
      this.statusTarget.value = "off"
      this.bandFormTarget.classList.remove("d-none");
      this.bandCardTarget.classList.remove("d-none");
      this.userFormTarget.classList.add("d-none");
      this.userCardTarget.classList.add("d-none");
     }
  }
}
