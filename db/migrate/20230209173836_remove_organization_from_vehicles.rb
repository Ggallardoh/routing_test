class RemoveOrganizationFromVehicles < ActiveRecord::Migration[7.0]
  def change
    remove_reference :vehicles, :organization, null: false, foreign_key: true
  end
end
