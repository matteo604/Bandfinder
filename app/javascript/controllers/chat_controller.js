import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "content"]

  connect() {
    this.scrollToBottom();
    this.startPollingForNewMessages(); // Start polling for new or updated messages
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
    const chatId = this.element.getAttribute("data-chat-id");
    const textArea = saveButton.previousElementSibling;
    const updatedContent = textArea.value;

    // Send AJAX request to update the message
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

        // Find the message footer (where the timestamp is)
        const messageFooter = document.querySelector(`.message-timestamp[data-message-id="${messageId}"]`);

        // Remove the textarea and add the updated message
        textArea.replaceWith(updatedMessage);
        saveButton.remove();

        // Add the "edited" indicator in the message footer, next to the timestamp
        let editedIndicator = messageFooter.querySelector('.edited-indicator');

        // If the edited indicator doesn't exist, create one
        if (!editedIndicator) {
          editedIndicator = document.createElement("span");
          editedIndicator.className = "edited-indicator";
          editedIndicator.style.fontSize = "smaller";
          editedIndicator.style.color = "gray";
          editedIndicator.innerHTML = " (message has been edited)";
          messageFooter.appendChild(editedIndicator);
        }

        // Ensure the edited indicator is visible in real-time
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

  // New: Start polling for new or updated messages
  startPollingForNewMessages() {
    const chatId = this.element.getAttribute("data-chat-id");

    if (!chatId || chatId === "null") {
      console.error("Invalid chat ID detected:", chatId);
      return;
    }

    setInterval(() => {
      fetch(`/chats/${chatId}/messages/check_updates`, {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
        }
      })
      .then(response => {
        // Ensure the response is JSON
        if (!response.ok) {
          throw new Error(`Server error: ${response.statusText}`);
        }
        return response.json();
      })
      .then(data => {
        // Check if there are updated messages
        if (data.updated_messages && data.updated_messages.length > 0) {
          this.updateMessages(data.updated_messages);
        }
      })
      .catch(error => {
        console.error("Error during polling:", error);
      });
    }, 5000); // Poll every 5 seconds
  }

  // New: Update the messages in the DOM
  updateMessages(updatedMessages) {
    updatedMessages.forEach(message => {
      const messageElement = document.querySelector(`.message-text[data-message-id="${message.id}"]`);

      if (messageElement) {
        // Update the message content
        messageElement.innerText = message.content;

        // Check if the message was edited and display the "edited" indicator
        let editedIndicator = document.querySelector(`.edited-indicator[data-message-id="${message.id}"]`);

        if (message.edited) {
          if (!editedIndicator) {
            // If there is no indicator, create one
            editedIndicator = document.createElement("span");
            editedIndicator.className = "edited-indicator";
            editedIndicator.style.fontSize = "smaller";
            editedIndicator.style.color = "gray";
            editedIndicator.dataset.messageId = message.id;
            editedIndicator.innerHTML = " (message has been edited)";
            messageElement.insertAdjacentElement('afterend', editedIndicator);
          } else {
            // Ensure the indicator is visible if it already exists
            editedIndicator.style.display = "inline";
          }
        } else if (editedIndicator) {
          // Hide the edited indicator if the message is not edited anymore
          editedIndicator.style.display = "none";
        }
      }
    });
  }
}
