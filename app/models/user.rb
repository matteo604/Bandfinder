class User < ApplicationRecord
  belongs_to :band, optional: true
  has_many :chats
  has_many :messages
  has_many :reviews
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
