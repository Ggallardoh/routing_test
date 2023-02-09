class RemoveConstraintsFromRoutes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :routes, :vehicle_id, true
    change_column_null :routes, :driver_id, true
  end
end
