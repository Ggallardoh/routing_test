class AddNameToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :name, :string
  end
end
