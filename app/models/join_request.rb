class JoinRequest < ApplicationRecord
  belongs_to :user
  belongs_to :band
end
