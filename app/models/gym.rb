class Gym < ApplicationRecord
  has_many :sessions
  has_many :users, through: :sessions
  has_many :exercises, through: :sessions
end
