class Route < ApplicationRecord
  include AASM

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
    end
    event :unschedule do
      transitions from: :scheduled, to: :unscheduled
      success do
        self.driver = nil
        self.vehicle = nil
      end
    end
  end

  def time
    "#{starts_at.to_formatted_s(:time)} - #{ends_at.to_formatted_s(:time)}"
  end

  def assignation
    driver.nil? ? 'Sin Asignar' : "#{driver.name}/#{vehicle.plate}"
  end

  private

  def overlapping_routes?
    routes = []
    routes << Route.scheduled.where.not(id:).with_driver(driver) if driver.present?
    routes << Route.scheduled.where.not(id:).with_vehicle(vehicle) if vehicle.present?
    period = Range.new starts_at, ends_at

    routes.none? do |route|
      route_period = Range.new route.starts_at, route.ends_at
      period.overlaps?(route_period)
    end
  end
end
