import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.startPollingTotalUnreadCount();
  }

  startPollingTotalUnreadCount() {
    setInterval(() => {
      fetch('/chats/unread_count', {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        }
      })
      .then(response => response.json())
      .then(data => {
        const unreadCountElement = document.querySelector('.unread-count-badge');
        if (data.unread_count > 0) {
          unreadCountElement.innerText = data.unread_count;
          unreadCountElement.style.display = "inline";
        } else {
          unreadCountElement.style.display = "none";
        }
      })
      .catch(error => {
        console.error("Error fetching total unread count:", error);
      });
    }, 1000);
  }
}
