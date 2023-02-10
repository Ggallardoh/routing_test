class RoutesController < ApplicationController
  before_action :set_resources, only: :index
  before_action :set_route, :set_driver, :set_vehicle, only: :assign
  def index
    @routes = Route.all
  end

  def assign
    if @route.may_schedule?(@driver, @vehicle)
      @route.schedule!(@driver, @vehicle)
      flash[:notice] = 'Ruta agendada'
    else
      flash[:alert] = @route.overlapping_routes_message(@driver, @vehicle)
    end
    redirect_to root_path
  end

  private

  def set_resources
    @routes = current_user.organization.routes
    @drivers = current_user.organization.drivers
    @vehicles = current_user.organization.vehicles
  end

  def set_route
    @route = Route.find_by_id(params[:route_id])
  end

  def set_driver
    @driver = Driver.find_by_id(params[:driver])
    redirect_to(root_path, flash: { error: 'Debe asignar conductor' }) if @driver.nil?
  end

  def set_vehicle
    @vehicle = Vehicle.find_by_id(params[:vehicle])
    redirect_to(root_path, flash: { error: 'Debe asignar vehiculo' }) if @vehicle.nil?
  end
end
