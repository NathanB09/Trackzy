class Gym < ApplicationRecord
  # include Geocoder::Model::Mongoid
  # include Geocoder::Model::MongoMapper

  has_many :workouts
  has_many :users, through: :workouts
  has_many :exercises, through: :workouts

  def location_to_address
    geo_localization = "#{self.location}"
    query = Geocoder.search(geo_localization).first
    query.address
  end

end
