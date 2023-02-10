class Route < ApplicationRecord
  include AASM

  belongs_to :organization
  belongs_to :driver, optional: true
  belongs_to :vehicle, optional: true

  validates :starts_at, :ends_at, :travel_time, :total_stops, :action, presence: true
  validates :travel_time, :total_stops, numericality: { only_integer: true }
  validates :action, inclusion: { in: %w[Salida Llegada] }

  scope :with_driver, ->(driver) { where(driver:) }
  scope :with_vehicle, ->(vehicle) { where(vehicle:) }

  aasm do
    state :unscheduled, initial: true
    state :scheduled

    event :schedule do
      transitions from: :unscheduled, to: :scheduled,
                  guard: :overlapping_routes?
      success do |driver, vehicle|
        self.driver = driver
        self.vehicle = vehicle
        save!
      end
    end
    event :unschedule do
      transitions from: :scheduled, to: :unscheduled
      success do
        self.driver = nil
        self.vehicle = nil
        save!
      end
    end
  end

  def time
    "#{starts_at.to_formatted_s(:time)} - #{ends_at.to_formatted_s(:time)}"
  end

  def assignation
    driver.nil? ? 'Sin Asignar' : "#{driver.name}/#{vehicle.plate}"
  end

  def overlapping_routes_message(driver, vehicle)
    msg = 'Vehiculo o conductor ya asignado a rutas:'
    overlapping_routes(driver, vehicle).each { |r| msg += " #{r.name}" }
    msg
  end

  private

  def overlapping_routes?(driver, vehicle)
    overlapping_routes(driver, vehicle).empty?
  end

  def overlapping_routes(driver, vehicle)
    other_routes = []
    Route.scheduled.where.not(id:).with_driver(driver).to_a.each { |r| other_routes << r }
    Route.scheduled.where.not(id:).with_vehicle(vehicle).to_a.each { |r| other_routes << r }
    period = Range.new starts_at, ends_at

    other_routes.select! do |other_route|
      route_period = Range.new other_route.starts_at, other_route.ends_at
      period.overlaps?(route_period)
    end
    other_routes.uniq
  end
end
