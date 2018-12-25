class User < ApplicationRecord
  has_many :workouts
  has_many :gyms, through: :workouts
  has_many :exercises, through: :workouts
  has_secure_password
end
