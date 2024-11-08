class BandSession < ApplicationRecord
  has_many :applications
  belongs_to :band
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
 # validates :title, :description, :address, presence: true (to be decided if must have it)
  validates :start_date, :end_date, presence: true

 # private

 # def session_length
 #  if end_date - start_date < 1.hour
  #    errors.add(:end_date, "Minimum of 1 hour!")
  #  end
  # end

end
