require 'rest-client'
require 'JSON'

def get_data_from_api_gyms_nearby_search(location) #NearbySearch! 1500m radius; location must be specified as latitude,longtude
  response_string = RestClient.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" + location + "&radius=1500&type=gym&rankby=prominence&key=")
  response_hash = JSON.parse(response_string)
  gyms_hash = {}
  response_hash["results"].each do |hash|
    gyms_hash[hash["name"]] = hash["geometry"]["location"]
  end
  gyms_hash #gives a big hash of several gyms with name => {lat =>, lng =>}
end

#get_data_from_api_gyms_nearby_search("51.520341,-0.087603")

def get_data_from_api_gyms_find_nearest_place(location) #Find Place gives 1 response only! This is the nearest thing
  response_string = RestClient.get("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=gym&locationbias=circle:500@" + location + "&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=")
  response_hash = JSON.parse(response_string)
  gyms_hash = {}
  response_hash["candidates"].each do |gym|
    gyms_hash[gym["name"]] = gym["formatted_address"]
  end
  gyms_hash
end

#get_data_from_api_gyms_find_nearest_place("51.520341,-0.087603")
