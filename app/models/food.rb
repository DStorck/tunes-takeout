require "httparty"
require 'yelp'

class Food < ActiveRecord::Base
  BASE_URL = "https://api.yelp.com/v2/search"
  attr_reader :business_id, :name, :url, :image_url, :phone, :rating

  def initialize(data)
    @business_id = data[:id]
    @name = data[:name]
    @url = data[:url]
    @image_url = data[:image_url]
    @phone = data[:phone]
    @rating = data[:rating]
  end

  def self.find_restaurant(id)
    Yelp.client.business(id)
  end

  def self.restaurant_id_array(response) #move this to food model
    @food_suggestions = response["suggestions"]
    @food_ids = @food_suggestions.map { |item| item["food_id"]}
  end

  def self.restaurant_instances(rest_ids)
    restaurants = []
    rest_ids.each do |id|
      restaurants << Yelp.client.business(id)
    end
    restaurants
  end

end
