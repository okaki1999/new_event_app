class Privacy < ApplicationRecord
  belongs_to :event, optional: true
end
