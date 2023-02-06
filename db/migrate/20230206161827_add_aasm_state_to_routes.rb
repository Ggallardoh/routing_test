class AddAasmStateToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :aasm_state, :string
  end
end
