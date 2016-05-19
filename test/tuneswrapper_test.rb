require 'test_helper'

class TunesTakeoutWrapperTest < ActiveSupport::TestCase

  describe "TTWrapper" do
    it "uses v1 of the API" do
      assert_equal "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query=" , TunesTakeoutWrapper::BASE_URL
    end

    describe "API" do
      before do
        @pizza_pairing = TunesTakeoutWrapper.search("pizza", 4)
      end

      it "returns a specified numbers of suggestions of food and music" do
        choices = @pizza_pairing['suggestions'].count
        assert_equal choices, 4
      end

      it "will retur top 20 choices to index" do

      end

      it "can favorite pairings" do
      end

      it 'can unfavorite pairings' do
      end

      it 'can collect ids of all favorite pairings' do
      end

      it 'can turn a collection of favorite ids into a collection of suggestions' do
      end

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
