class Gym < ApplicationRecord

  has_many :workouts
  has_many :users, through: :workouts
  has_many :exercises, through: :workouts

  def self.add_gyms(name, location)
    self.create(name: name, location: location.join(",")) unless self.find_by(name: name)
  end

  def location_to_address
    geo_localization = "#{self.location}"
    query = Geocoder.search(geo_localization).first
    query.address
  end

  def nearest_gym(postcode)
    coords = get_coordinates(postcode)
    get_data_from_api_gyms_find_nearest_place(coords)
  end

  def local_gyms(postcode)
    string = get_coordinates(postcode)
    gyms_hash = get_data_from_api_gyms_nearby_search(string)
    gyms_hash.each do |gym, location|
      results = Geocoder.search([location[0], location[1]])
      results.first.address
    end
    gyms_hash
  end

  def get_coordinates(search_term)
    results = Geocoder.search(search_term)
    results.first.coordinates.join(",")
  end

  def get_address(coordinates)
    results = Geocoder.search(coordinates.split(","))
    results.first.address
  end

  def get_data_from_api_gyms_nearby_search(location) #NearbySearch with 1500m radius; location must be specified as latitude,longtude
    response_string = RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + location + "&radius=1500&type=gym&rankby=prominence&key=AIzaSyCRy-gJvn2d98IQU6CYLc6kMfisMl5M-bM")
    response_hash = JSON.parse(response_string)
    gyms_hash = {}
    response_hash["results"].each do |hash|
      array = []
      gyms_hash[hash["name"]] = array
      array << hash["geometry"]["location"]["lat"]
      array << hash["geometry"]["location"]["lng"]
    end
     gyms_hash
  end

  def get_data_from_api_gyms_find_nearest_place(location) #Find Place gives 1 response only, this is the nearest gym
    response_string = RestClient.get("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=gym&locationbias=circle:500@" + location + "&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=AIzaSyCRy-gJvn2d98IQU6CYLc6kMfisMl5M-bM")
    response_hash = JSON.parse(response_string)
    gyms_hash = {}
    response_hash["candidates"].each do |gym|
      gyms_hash[gym["name"]] = gym["formatted_address"]
    end
    gyms_hash
  end

end
