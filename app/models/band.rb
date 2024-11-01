class Band < ApplicationRecord
  has_many :reviews
  has_many :users
  belongs_to :leader, class_name: "User", foreign_key: 'leader_id'
  validates :title, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
  has_many :band_sessions, dependent: :destroy
end
