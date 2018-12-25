class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :gym
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises
end
