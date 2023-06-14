import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
// import { formatDate } from "flatpickr/dist/utils/dates";

export default class extends Controller {
  connect() {
    new flatpickr(this.element, {
      enableTime: true,
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d"
      // more options available on the documentation!
    });
  }
}
