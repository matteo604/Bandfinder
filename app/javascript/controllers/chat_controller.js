// app/javascript/controllers/chat_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "content"]

  connect() {
    this.scrollToBottom();
  }

  scrollToBottom() {
    const messagesContainer = this.element.querySelector(".messages-container");
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }

  preventEmptySubmit(event) {
    const content = this.contentTarget.value.trim();
    if (content === "") {
      event.preventDefault(); // prevent form submission
      alert("Message cannot be empty!"); // nnotify user
    }
  }
}
