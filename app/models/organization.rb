class Organization < ApplicationRecord
  has_many :users
  has_many :routes
  has_many :drivers
  has_many :vehicles
end
