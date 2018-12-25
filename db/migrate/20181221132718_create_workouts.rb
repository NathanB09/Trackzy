class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.integer :user_id
      t.integer :gym_id
      t.date :workout_date

      t.timestamps
    end
  end
end
