class CreateDesireds < ActiveRecord::Migration
  def change
    create_table :desireds do |t|
      t.integer :user_id
      t.integer :language_id

      t.timestamps null: false
    end
  end
end
