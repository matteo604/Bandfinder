// app/javascript/controllers/toggle_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "toggleSwitch", "userCard", "bandCard", "toggleMarkers", "bandForm",
    "userForm", "slider", "status", "changeViewButton", "changedArea",
    "indexArea", "bandIndex", "userIndex", "labelLeft", "labelRight"
  ];
  connect(){
    this.labelLeftTarget.classList.add('label-active');
    this.labelRightTarget.classList.add('label-inactive');
  }
  changeStatus(){
    if (this.changeViewButtonTarget.status == "map-view"){
      this.changedAreaTarget.classList.add("d-block")
      this.changedAreaTarget.classList.remove("d-none")
      this.changeViewButtonTarget.status = "list-view"
      this.changeViewButtonTarget.innerHTML = "list view"
      this.indexAreaTarget.classList.add("d-none")
    } else {
      this.changedAreaTarget.classList.add("d-none")
      this.changeViewButtonTarget.status = "map-view"
      this.changedAreaTarget.classList.remove("d-block")
      this.indexAreaTarget.classList.remove("d-none")
      this.changeViewButtonTarget.innerHTML = "map view"
    }
  }

  toggleContent() {
    if (this.toggleSwitchTarget.checked) {
        this.statusTarget.value = "on";
        this.userFormTarget.classList.remove("d-none");
        this.userCardTarget.classList.remove("d-none");
        this.bandFormTarget.classList.add("d-none");
        this.bandCardTarget.classList.add("d-none");
        this.bandIndexTarget.classList.add("d-none");
        this.userIndexTarget.classList.remove("d-none");

        // Change label classes for active/inactive states
        this.labelLeftTarget.classList.add('label-inactive');
        this.labelLeftTarget.classList.remove('label-active');
        this.labelRightTarget.classList.add('label-active');
        this.labelRightTarget.classList.remove('label-inactive');
    } else {
        this.statusTarget.value = "off";
        this.bandFormTarget.classList.remove("d-none");
        this.bandCardTarget.classList.remove("d-none");
        this.userFormTarget.classList.add("d-none");
        this.userCardTarget.classList.add("d-none");
        this.bandIndexTarget.classList.remove("d-none");
        this.userIndexTarget.classList.add("d-none");

        // Change label classes for active/inactive states
        this.labelLeftTarget.classList.remove('label-inactive');
        this.labelLeftTarget.classList.add('label-active');
        this.labelRightTarget.classList.remove('label-active');
        this.labelRightTarget.classList.add('label-inactive');
    }
  }
}
