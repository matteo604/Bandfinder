// app/javascript/controllers/datepicker_controller.js

import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

export default class extends Controller {
  connect() {
    const checkInInput = document.querySelector("#check-in");
    const checkOutInput = document.querySelector("#check-out");

    flatpickr(checkInInput, {
      // dateFormat: "d-m-Y",
      minDate: "today",
      onChange: (selectedDates) => {
        if (selectedDates.length > 0) {
          const startDate = selectedDates[0];
          const endDate = new Date(startDate);
          endDate.setDate(startDate.getDate() + 1);
          if (checkOutInput._flatpickr) {
            checkOutInput._flatpickr.set("minDate", endDate);
          }
        }
      }
    });

    flatpickr(checkOutInput, {
      // dateFormat: "Y-m-d",
      minDate: new Date().setDate(new Date().getDate() + 1)
    });
  }
}
