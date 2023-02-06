class Route < ApplicationRecord
  belongs_to :organization
  belongs_to :driver, optional: true
  belongs_to :vehicle, optional: true

  validates :starts_at, :ends_at, :travel_time, :total_stops, :action, presence: true

  scope :with_driver, ->(driver) { where(driver:) }
  scope :with_vehicle, ->(vehicle) { where(vehicle:) }

  aasm do
    state :unscheduled, initial: true
    state :scheduled

    event :schedule do
      transitions from: :unscheduled, to: :scheduled,
                  guard: :no_overlapping_routes?
      success do |driver, vehicle|
        self.driver = driver
        self.vehicle = vehicle
      end
    end
    event :unschedule do
      transitions from: :scheduled, to: :unscheduled
      success do
        self.driver = nil
        self.vehicle = nil
      end
    end
  end

  private

  def overlapping_routes?
    routes = Route.where.not(id:).with_driver(driver).with_vehicle(vehicle)
    routes.none? do |route|
      period = Range.new starts_at, ends_at
      route_period = Range.new route.starts_at, route.ends_at
      period.overlaps?(route_period)
    end
  end
end
