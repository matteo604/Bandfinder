class Band < ApplicationRecord
  has_many :users
  has_many :chats
  has_many :reviews

  validates :title, presence: true
end
