class CreateWorkoutExcercises < ActiveRecord::Migration[5.2]
  def change
    create_table :workout_excercises do |t|
      t.integer :workout_id
      t.integer :exercise_id

      t.timestamps
    end
  end
end
