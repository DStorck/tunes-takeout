require 'test_helper'

class TunesTakeoutWrapperTest < ActiveSupport::TestCase

  describe "TTWrapper" do
    it "uses v1 of the API" do
      assert_equal "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query=" , TunesTakeoutWrapper::BASE_URL
    end

    describe "API" , :vcr do
      before do
        @pizza_pairing = TunesTakeoutWrapper.search("pizza", 4)
        @top_twenty = TunesTakeoutWrapper.top_twenty
        @favorite_id_array = TunesTakeoutWrapper.favorite_ids("dronaldson")
      end


      it "returns a specified numbers of suggestions of food and music" , :vcr do
        choices = @pizza_pairing['suggestions'].count
        assert_equal choices, 4
      end

      it "defaults to returning 5 suggestions if user doesn't provide a limit", :vcr do
        @choices = TunesTakeoutWrapper.search("pizza")
        assert_equal @choices["suggestions"].count , 5
      end


      it "returns suggestions that contain food_ids", :vcr do
        refute_nil @pizza_pairing["suggestions"].first["food_id"]
      end

      it "returns suggestions that contain music ids", :vcr do
        refute_nil @pizza_pairing["suggestions"].first["music_id"]
      end

      it "returns suggestions that contain music types", :vcr do
        refute_nil @pizza_pairing["suggestions"].first["music_type"]
      end

      it "will return top 20 choices to index", :vcr do
        assert_equal @top_twenty.class, Array
        assert_equal @top_twenty.count, 20
        assert_equal @top_twenty.last.class, Hash
        refute_nil @top_twenty.last["food_id"]
      end

      it "can create an array of suggestion of ids out of the API response", :vcr do
        assert_equal @favorite_id_array.class, Array
      end

      it "can favorite a suggestion" , :vcr do
        @original_count = @favorite_id_array.count
        TunesTakeoutWrapper.favorite('dronaldson', "Vz92VPLW7wADpNDB")
        @new_count = TunesTakeoutWrapper.favorite_ids("dronaldson").count

        assert_equal (@original_count + 1), @new_count
      end

      it "can unfavorite a suggestion", :vcr do
        TunesTakeoutWrapper.favorite('dronaldson', "Vz9hW_LW7wADpMt8")
        @original_count = @favorite_id_array.count
        TunesTakeoutWrapper.unfavorite('dronaldson', "Vz9hW_LW7wADpMt8")
        @new_count = TunesTakeoutWrapper.favorite_ids("dronaldson").count
        assert_equal (@original_count - 1), @new_count
      end

    end
  end
end
