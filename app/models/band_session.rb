class BandSession < ApplicationRecord
  has_many :applications
  belongs_to :band
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  validates :title, :description, :address, presence: true
  validates :start_date, :end_date, presence: true
end

