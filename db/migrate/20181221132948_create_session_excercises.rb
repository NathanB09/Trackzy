class CreateSessionExcercises < ActiveRecord::Migration[5.2]
  def change
    create_table :session_excercises do |t|
      t.integer :session_id
      t.integer :exercise_id

      t.timestamps
    end
  end
end
