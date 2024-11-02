class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :band_leader, class_name: "User", foreign_key: "band_leader_id" # associate band_leader_id with user
  has_many :messages, dependent: :destroy
end
