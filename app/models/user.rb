class User < ApplicationRecord
  belongs_to :band, optional: true
  has_many :chats, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :photo
  has_many :join_requests

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # Method to check if the user is a band leader
  def band_leader?
    leader == true
  end

  def leads_band?
    Band.exists?(leader_id: self.id)
  end
end
