class User < ApplicationRecord

  has_many :workouts
  has_many :gyms, through: :workouts
  has_many :exercises, through: :workouts

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # def nearest_gym(postcode)
  #   get_data_from_api_gyms_find_nearest_place(postcode)
  # end

  def local_gyms(postcode)
    string = get_coordinates(postcode)
    gyms_hash = get_data_from_api_gyms_nearby_search(string)
    gyms_hash.each do |gym, location|
      results = Geocoder.search([location[0], location [1]])
      results.first.address
    end
    puts gyms_hash
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

  #get_data_from_api_gyms_nearby_search("51.520341,-0.087603")

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
