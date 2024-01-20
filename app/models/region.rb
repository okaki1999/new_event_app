class Region < ApplicationRecord
  belongs_to :prefecture
  has_many :events, dependent: :destroy
  has_many :user
end
