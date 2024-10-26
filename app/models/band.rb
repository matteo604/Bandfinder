class Band < ApplicationRecord
  has_many :reviews, :users
  belongs_to :band_leader, class_name: "User"

  validates :title, presence: true
end
