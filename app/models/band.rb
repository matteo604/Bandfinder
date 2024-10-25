class Band < ApplicationRecord
  has_many :reviews
  belongs_to :band_leader, class_name: "User"

  validates :title, presence: true
end
