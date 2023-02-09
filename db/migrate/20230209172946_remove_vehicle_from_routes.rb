class RemoveVehicleFromRoutes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :routes, :vehicle, null: false, foreign_key: true
  end
end
