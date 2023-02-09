class AddOrganizationToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :organization, null: false, foreign_key: true
  end
end
