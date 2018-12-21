class Session < ApplicationRecord
  belongs_to :user
  belongs_to :gym
  has_many :session_exercises
  has_many :exercises, through: :session_exercises
end
