class CreateJoinTableAppPet < ActiveRecord::Migration[5.1]
  def change
    create_table :apps_pets do |t|
      t.references :app, foreign_key: true
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
