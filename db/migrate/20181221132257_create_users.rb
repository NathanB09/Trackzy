class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :height_cm
      t.integer :weight_kg

      t.timestamps
    end
  end
end
