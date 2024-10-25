class Review < ApplicationRecord
  belongs_to :user
  belongs_to :band

  validates :rating, :content,  presence: true
end
