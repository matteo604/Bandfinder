class Session < ApplicationRecord
  has_many :applications
  belongs_to :band
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
end