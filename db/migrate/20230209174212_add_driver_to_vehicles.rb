class AddDriverToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :driver, null: false, foreign_key: true
  end
end
