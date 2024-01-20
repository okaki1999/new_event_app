class Prefecture < ApplicationRecord
  has_many :regions 
  has_many :events
end
