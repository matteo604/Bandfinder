
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  # vvalidation to ensure the content is not empty
  validates :content, presence: true

  # Mark the message as read
  def mark_as_read
    update(read: true)
  end

  # Check if the message has been edited
  def edited?
    created_at != updated_at
  end

  def user_name
    user.first_name
  end

end
