class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  # Validation to ensure the content is not empty
  validates :content, presence: true

  # Mark the message as read
  def mark_as_read
    update(read: true)
  end
end
