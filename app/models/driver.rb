class Driver < ApplicationRecord
  has_one :vehicle
  belongs_to :organization
end
