class AddApprovedToAppsPets < ActiveRecord::Migration[5.1]
  def change
    add_column :apps_pets, :approved, :boolean, default: false
  end
end
