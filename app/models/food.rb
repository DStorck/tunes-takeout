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

  def self.find(id)
    data = HTTParty.get("https://api.yelp.com/v2/business/yelp-san-francisco").parsed_response

    self.new(data)
  end

end
