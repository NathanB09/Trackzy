class Workout < ApplicationRecord
  belongs_to :user
  # belongs_to :gym
  has_many :workout_exercises, inverse_of: :workout
  has_many :exercises, through: :workout_exercises
  accepts_nested_attributes_for :workout_exercises, allow_destroy: true

  def exercise_num(num)
    num.to_i.times { self.workout_exercises.build.build_exercise } if num
  end

  def delete_workout
    self.exercises.each do |exercise|
      exercise.destroy
    end
    self.workout_exercises.destroy_all
    self.destroy
  end
end
