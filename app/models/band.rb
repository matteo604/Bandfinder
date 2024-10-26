class Band < ApplicationRecord
  has_many :reviews
  has_many :users
  belongs_to :leader, class_name: "User", foreign_key: 'leader_id'
  validates :title, presence: true
end
