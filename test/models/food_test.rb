require 'test_helper'

class FoodTest < ActiveSupport::TestCase

  describe "Food Model",  :vcr do

    it "can find a restaurant on yelp api and turn it into a food instance", :vcr do
      @new_eats = Food.find_restaurant("yelp-san-francisco")
      assert_equal @new_eats.class, Food
      assert_equal @new_eats.business_id, "yelp-san-francisco"
      assert_equal @new_eats.name, "Yelp"
      assert_equal @new_eats.address, "140 New Montgomery St"
      assert_equal @new_eats.city, "San Francisco"
      assert_equal @new_eats.phone, "+1-415-908-3801"
      assert_equal @new_eats.image, "https://s3-media3.fl.yelpcdn.com/bphoto/nQK-6_vZMt5n88zsAS94ew/ms.jpg"
    end

  end
end
