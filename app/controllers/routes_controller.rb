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
      redirect_to root_path
    else
      flash[:alert] = @route.overlapping_routes_message(@driver, @vehicle)
      redirect_to root_path, overlap: @route.overlapping_route
    end
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
    flash[:alert] = 'Debe asignar conductor' && (redirect_to root_path) if @driver.nil?
  end

  def set_vehicle
    @vehicle = Vehicle.find_by_id(params[:vehicle])
    flash[:alert] = 'Debe asignar vehiculo' && (redirect_to root_path) if @vehicle.nil?
  end
end
