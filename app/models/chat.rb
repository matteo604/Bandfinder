class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :band
  has_many :messages, dependent: :destroy
end
