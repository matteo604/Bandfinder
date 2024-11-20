import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "content", "unreadCount", "messagesContainer"];

  connect() {
    this.scrollToBottom();
    this.startPollingForNewMessages();
    this.currentUserId = parseInt(this.element.dataset.currentUserId, 10);
  }

  scrollToBottom() {
    const messagesContainer = this.element.querySelector(".messages-container");
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  }

  markAllMessagesAsRead() {
    fetch('/chats/mark_all_as_read', {
      method: "GET",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        console.log("All messages marked as read.");
      }
    })
    .catch(error => {
      console.error("Error marking messages as read:", error);
    });
  }

  preventEmptySubmit(event) {
    const content = this.contentTarget.value.trim();
    if (content === "") {
      event.preventDefault();
      alert("Message cannot be empty!");
    }
  }

  editMessage(event) {
    event.preventDefault();
    const editButton = event.currentTarget;
    const messageId = editButton.dataset.messageId;
    const messageText = document.querySelector(`.message-text[data-message-id='${messageId}']`);
    const textArea = document.createElement("textarea");
    textArea.className = "message-edit-input";
    textArea.value = messageText.innerText;
    messageText.replaceWith(textArea);
    const saveButton = document.createElement("button");
    saveButton.innerText = "Save";
    saveButton.className = "btn btn-primary btn-sm save-message-button";
    saveButton.setAttribute("data-action", "click->chat#saveMessage");
    saveButton.setAttribute("data-message-id", messageId);
    textArea.insertAdjacentElement('afterend', saveButton);
  }

  saveMessage(event) {
    event.preventDefault();
    const saveButton = event.currentTarget;
    const messageId = saveButton.dataset.messageId;
    const chatId = this.element.getAttribute("data-chat-id");
    const textArea = saveButton.previousElementSibling;
    const updatedContent = textArea.value;
    fetch(`/chats/${chatId}/messages/${messageId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ message: { content: updatedContent } })
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        const updatedMessage = document.createElement("span");
        updatedMessage.className = "message-text";
        updatedMessage.dataset.messageId = messageId;
        updatedMessage.innerText = updatedContent;
        const messageFooter = document.querySelector(`.message-timestamp[data-message-id="${messageId}"]`);
        textArea.replaceWith(updatedMessage);
        saveButton.remove();
        let editedIndicator = messageFooter.querySelector('.edited-indicator');
        if (!editedIndicator) {
          editedIndicator = document.createElement("span");
          editedIndicator.className = "edited-indicator";
          editedIndicator.style.fontSize = "smaller";
          editedIndicator.style.color = "gray";
          editedIndicator.innerHTML = " (message has been edited)";
          messageFooter.appendChild(editedIndicator);
        }
        editedIndicator.style.display = "inline";
      } else {
        alert("There was an error updating the message.");
      }
    });
  }

  deleteMessage(event) {
    event.preventDefault();
    const deleteButton = event.currentTarget;
    if (confirm("Are you sure you want to delete this message?")) {
      fetch(deleteButton.href, {
        method: "DELETE",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        }
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          const messageElement = document.querySelector(`.message-text[data-message-id="${data.message_id}"]`);
          if (messageElement) {
            messageElement.innerText = "This message was deleted by the author.";
          }
          const editButtonElement = document.querySelector(`.edit-message[data-message-id="${data.message_id}"]`);
          const deleteButtonElement = document.querySelector(`.delete-message[data-message-id="${data.message_id}"]`);
          if (editButtonElement) {
            editButtonElement.remove();
          }
          if (deleteButtonElement) {
            deleteButtonElement.remove();
          }
        } else {
          alert("There was an error deleting the message.");
        }
      });
    }
  }

  startPollingForNewMessages() {
    const chatId = this.element.getAttribute("data-chat-id");
    if (!chatId || chatId === "null") {
      console.error("Invalid chat ID detected:", chatId);
      return;
    }
    this.processedMessageIds = new Set();
    this.lastPollTime = new Date().toISOString();
    setInterval(() => {
      fetch(`/chats/${chatId}/messages/check_updates?last_poll=${this.lastPollTime}`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        }
      })
      .then(response => response.json())
      .then(data => {
        if (data.new_messages && data.new_messages.length > 0) {
          data.new_messages.forEach(message => {
            if (message.user_id !== this.currentUserId && !this.processedMessageIds.has(message.id)) {
              this.addMessageToContainer(message);
              this.processedMessageIds.add(message.id);
            }
          });
        }
        if (data.updated_messages && data.updated_messages.length > 0) {
          this.updateMessages(data.updated_messages);
        }
        this.lastPollTime = new Date().toISOString();
      })
      .catch(error => {
        console.error("Error during polling:", error);
      });
    }, 1000);
  }

  updateMessages(updatedMessages) {
    updatedMessages.forEach(message => {
      const messageElement = document.querySelector(`.message-text[data-message-id="${message.id}"]`);
      if (messageElement) {
        console.log("Updating message content for message ID:", message.id);
        messageElement.innerText = message.content;
        let editedIndicator = document.querySelector(`.edited-indicator[data-message-id="${message.id}"]`);
        if (message.edited) {
          if (!editedIndicator) {
            editedIndicator = document.createElement("span");
            editedIndicator.className = "edited-indicator";
            editedIndicator.style.fontSize = "smaller";
            editedIndicator.style.color = "gray";
            editedIndicator.dataset.messageId = message.id;
            editedIndicator.innerHTML = " (message has been edited)";
            messageElement.insertAdjacentElement('afterend', editedIndicator);
          } else {
            editedIndicator.style.display = "inline";
          }
        } else if (editedIndicator) {
          editedIndicator.style.display = "none";
        }
      } else {
        console.log("No message element found for ID:", message.id);
      }
    });
  }

  addMessageToContainer(message) {
    if (document.querySelector(`.message-card[data-message-id="${message.id}"]`)) {
      return;
    }
    const messageElement = document.createElement("div");
    messageElement.className = `message-card ${message.user_id === this.currentUserId ? 'current-user' : 'other-user'}`;
    messageElement.dataset.messageId = message.id;
    messageElement.innerHTML = `
      <p class="message-content"><strong>${message.user_name}:</strong> ${message.content}</p>
      <div class="message-timestamp">${formatTimeAgo(message.created_at)}</div>
    `;
    this.messagesContainerTarget.appendChild(messageElement);
    this.scrollToBottom();
  }
}

// Hilfsfunktion zur Berechnung der vergangenen Zeit
function formatTimeAgo(date) {
  const now = new Date();
  const messageDate = new Date(date);
  const secondsAgo = Math.floor((now - messageDate) / 1000);

  if (secondsAgo < 60) {
    return "Just now";
  } else if (secondsAgo < 3600) {
    const minutes = Math.floor(secondsAgo / 60);
    return `${minutes} minute${minutes > 1 ? 's' : ''} ago`;
  } else if (secondsAgo < 86400) {
    const hours = Math.floor(secondsAgo / 3600);
    return `${hours} hour${hours > 1 ? 's' : ''} ago`;
  } else {
    // Falls die Nachricht älter als 24 Stunden ist, zeige das Datum an
    return messageDate.toLocaleDateString("de-DE", { year: 'numeric', month: '2-digit', day: '2-digit' });
  }
}
