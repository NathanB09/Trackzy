class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :name
      t.integer :user_id
      t.integer :gym_id
      t.date :session_date

      t.timestamps
    end
  end
end
