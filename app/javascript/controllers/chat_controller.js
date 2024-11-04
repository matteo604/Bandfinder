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
      event.preventDefault();
      alert("Message cannot be empty!");
    }
  }

  editMessage(event) {
    event.preventDefault();

    const editButton = event.currentTarget;
    const messageId = editButton.dataset.messageId;
    const messageText = document.querySelector(`.message-text[data-message-id='${messageId}']`);

    // Create a text area for editing
    const textArea = document.createElement("textarea");
    textArea.className = "message-edit-input";
    textArea.value = messageText.innerText;

    // Replace the message text with the text area
    messageText.replaceWith(textArea);

    // Add a save button with Stimulus action
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
    const chatId = this.element.getAttribute("data-chat-id"); // Get chat ID from the data attribute
    const textArea = saveButton.previousElementSibling;
    const updatedContent = textArea.value;

    // Send AJAX request to update the message
    fetch(`/chats/${chatId}/messages/${messageId}`, {  // Include chat_id in the URL
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

        // Add "edited" indicator if the message was edited
        if (data.edited) {
          const editedIndicator = document.createElement("span");
          editedIndicator.className = "edited-indicator";
          editedIndicator.innerHTML = " <i class='fas fa-edit'></i> Edited"; // Edited icon
          updatedMessage.insertAdjacentElement('afterend', editedIndicator);
        }

        textArea.replaceWith(updatedMessage);
        saveButton.remove();
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
          // Replace message content with deleted notice
          const messageElement = document.querySelector(`.message-text[data-message-id="${data.message_id}"]`);
          if (messageElement) {
            messageElement.innerText = "This message was deleted by the author.";
          }

          // Remove the edit and delete buttons for this message
          const editButtonElement = document.querySelector(`.edit-message[data-message-id="${data.message_id}"]`);
          const deleteButtonElement = document.querySelector(`.delete-message[data-message-id="${data.message_id}"]`);

          if (editButtonElement) {
            editButtonElement.remove(); // Remove the edit button after deletion
          }
          if (deleteButtonElement) {
            deleteButtonElement.remove(); // Remove the delete button after deletion
          }
        } else {
          alert("There was an error deleting the message.");
        }
      });
    }
  }
}
