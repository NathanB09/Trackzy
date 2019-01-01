class Workout < ApplicationRecord
  belongs_to :user
  # belongs_to :gym
  has_many :workout_exercises, inverse_of: :workout
  has_many :exercises, through: :workout_exercises
  accepts_nested_attributes_for :workout_exercises, allow_destroy: true

  validates :name, presence: true

  def exercise_num(num)
    num.to_i.times { self.workout_exercises.build.build_exercise } if num
  end

  def delete_workout
    self.exercises.each(&:destroy)
    self.workout_exercises.destroy_all
    self.destroy
  end

  def delete_exercises
    self.exercises.each(&:destroy)
    self.workout_exercises.destroy_all
  end
end
