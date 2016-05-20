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
        assert_equal @top_twenty.first.class, Hash
        refute_nil @top_twenty.first["food_id"]
      end

      it "can create an array of suggestion of ids out of the API response", :vcr do
        assert_equal @favorite_id_array.class, Array
      end

      it "can favorite a suggestion" , :vcr do
        @original_count = @favorite_id_array.count
        TunesTakeoutWrapper.favorite('dronaldson', "Vz9hW_LW7wADpMt8")
        @new_count = TunesTakeoutWrapper.favorite_ids("dronaldson").count

        assert_equal (@original_count + 1), @new_count

      end

      it "can unfavorite a suggestion", :vcr do
        @original_count = @favorite_id_array.count
        TunesTakeoutWrapper.unfavorite('dronaldson', "Vz9hW_LW7wADpMt8")
        @new_count = TunesTakeoutWrapper.favorite_ids("dronaldson").count
        assert_equal (@original_count - 1), @new_count
      end



      #
      # check difference between number of favorites before and after
      # it "can favorite pairings" do
      # end
      #
      # it 'can unfavorite pairings' do
      # end
      #
      # check class of array
      # it 'can collect ids of all favorite pairings' do
      # end
      #
      # it 'can turn a collection of favorite ids into a collection of suggestions' do
      # end

    end


  end
end


#   describe "API" do
#     before do
#       @bulbasaur = Pokemon.find(1)
#     end
#
#     it "knows its name", :vcr do
#       assert_equal "bulbasaur", @bulbasaur.name
#     end
#
#     it "doesn't have nils in its sprites", :vcr do
#       refute @bulbasaur.sprite_urls.any? { |s| s.nil? }
#     end
#
#     it "knows that it has moves", :vcr do
#       assert_instance_of Array, @bulbasaur.moves
#     end
#   end
# end
