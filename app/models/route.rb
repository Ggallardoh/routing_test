class Route < ApplicationRecord
  belongs_to :organization
  belongs_to :driver
  belongs_to :vehicle
end
