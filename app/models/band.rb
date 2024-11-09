class Band < ApplicationRecord
  has_many :reviews
  has_many :members, class_name: 'User', foreign_key: 'band_id'
  has_many :band_sessions, dependent: :destroy
  belongs_to :leader, class_name: "User", foreign_key: 'leader_id'
  validates :title, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
  has_many :band_sessions, dependent: :destroy

  def city_and_country
    if address.present?
      # Teile die Adresse auf und nimm nur die letzten beiden Elemente (vermutlich Stadt und Land)
      parts = address.split(',')
      parts = parts.last(2).map(&:strip) # Nimm die letzten zwei Teile und entferne Leerzeichen
      parts.join(', ')
    else
      "Address not available"
    end
  end
end
