class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image
      t.string :name
      t.float :approximate_age
      t.string :sex
      t.references :shelter, foreign_key: true

      t.timestamps
    end
  end
end
