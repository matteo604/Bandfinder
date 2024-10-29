// scrolls hopefully automatically to the last message
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.scrollToBottom();
  }

  scrollToBottom() {
    const messagesContainer = this.element.querySelector(".messages-container");
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }
}
