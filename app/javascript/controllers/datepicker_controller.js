// app/javascript/controllers/datepicker_controller.js

import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

export default class extends Controller {
  connect() {
    const checkInInput = document.querySelector("#check-in");
    const checkOutInput = document.querySelector("#check-out");

    flatpickr(checkInInput, {
      enableTime: true,
      dateFormat: "d/m/Y H:i",
      time_24hr: true,
      minDate: "today",
      onChange: (selectedDates) => {
        if (selectedDates.length > 0) {
          const startDate = selectedDates[0];
          const endDate = new Date(startDate);
          endDate.setDate(startDate.getDate());
          if (checkOutInput._flatpickr) {
            checkOutInput._flatpickr.set("minDate", endDate);
          }
        }
      }
    });

    flatpickr(checkOutInput, {
      enableTime: true,
      dateFormat: "d/m/Y H:i",
      time_24hr: true,
      minDate: new Date().setDate(new Date().getDate())
    });

    // form.addEventListener("submit", function(event) {
    //   const startDate = new Date(document.getElementById('band_session_start_date').value);
    //   const endDate = new Date(document.getElementById('band_session_end_date').value);
    //   console.log(document.getElementById('band_session_start_date'));

    //   const duration = (endDate - startDate) / 1000 / 60 / 60;
    //   if (duration < 1) {
    //     alert("The session must last at least 1 hour.");
    //     event.preventDefault();
    //   }
    // });
  }
}
