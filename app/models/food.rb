require "httparty"
require 'yelp'

class Food
  BASE_URL = "https://api.yelp.com/v2/search"
  attr_reader :business_id, :name, :address, :city, :phone, :rating_url, :image_url

  def initialize(data = nil)
    @business_id = data.id
    @name = data.name
    @address = data.location.address.first
    @city = data.location.city
    @phone = data.display_phone
    @rating_url = data.rating_img_url
    @image_url = data.image_url
  end

  def self.find_restaurant(id)
    info = Yelp.client.business(id.parameterize)
    info = info.business
    return self.new(info)
  end

  def self.restaurant_id_array(response) #move this to food model
    @food_suggestions = response["suggestions"]
    @food_ids = @food_suggestions.map { |item| item["food_id"]}
  end

  def self.restaurant_instances(rest_ids)
    restaurants = []
    rest_ids.each do |id|
      restaurants << self.find_restaurant(id)
    end
    restaurants
  end

end
