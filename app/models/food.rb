require "httparty"
require 'yelp'

class Food < ActiveRecord::Base
  BASE_URL = "https://api.yelp.com/v2/search"
  attr_reader :business_id, :name, :address, :city, :phone, :rating_url, :image

  def initialize(data = nil)
    @business_id = data.id
    @name = data.name
    @address = data.location.address.first
    @city = data.location.city
    @phone = data.display_phone
    @rating_url = data.rating_img_url
    @image = data.image_url
  end

  def self.find_restaurant(id)
    info = Yelp.client.business(id.parameterize)
    info = info.business
    return self.new(info)
  end

end
