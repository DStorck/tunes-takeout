require 'yelp'
require_relative "../../lib/TunesTakeoutWrapper"

class FoodController < ApplicationController
# BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query="

  def show

    @search = TunesTakeoutWrapper.search(params[:term])
    @music = TunesTakeoutWrapper.music(@search)
    @music_stuff = []
    @music.each do |id, type|
      @music_stuff << TunesTakeoutWrapper.music_search(id, type)
    
    end



  end
  #
  # def show
  #   @search_term = params[:term]
  #   @response = HTTParty.get(BASE_URL + "#{@search_term}" + "&limit=3&seed=banana")
  #   @music_type = @response["suggestions"].first["music_type"]
  #   @music_id = @response["suggestions"].first["music_id"]
  #   case @music_type
  #   when "album" then @search = RSpotify::Album.find(@music_id)
  #   when "track" then @search = RSpotify::Track.find(@music_id)
  #   when "playlist" then @search = RSpotify::Playlist.find(@music_id)
  #   when "artist" then @search = RSpotify::Artist.find(@music_id)
  #   end
  #
  #
  # end

end



#  /v2RSpotify::Artist.find(params[:artist])/business/{id}  method - get  - look up business by id
