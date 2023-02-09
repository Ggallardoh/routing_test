class RemoveDriverFromVehicles < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vehicles, :driver, null: false, foreign_key: true
  end
end
