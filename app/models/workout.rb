class Workout < ApplicationRecord
  belongs_to :user
  # belongs_to :gym
  has_many :workout_exercises, inverse_of: :workout
  has_many :exercises, through: :workout_exercises
  accepts_nested_attributes_for :workout_exercises
end
