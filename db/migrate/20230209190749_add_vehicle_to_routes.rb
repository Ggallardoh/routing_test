class AddVehicleToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_reference :routes, :vehicle, null: false, foreign_key: true
  end
end
