class User < ApplicationRecord
  has_many :sessions
  has_many :gyms, through: :sessions
  has_many :exercises, through: :sessions
end
