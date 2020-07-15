class CreateJoinTableAppPet < ActiveRecord::Migration[5.1]
  def change
    create_join_table :apps, :pets do |t|
      t.references :app, foreign_key: true
      t.references :pet, foreign_key: true
    end
  end
end
