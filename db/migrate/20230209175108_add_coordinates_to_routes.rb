class AddCoordinatesToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :coordinates, :jsonb
  end
end
