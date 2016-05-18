require 'yelp'
require_relative "../../lib/TunesTakeoutWrapper"

class SuggestionsController < ApplicationController

  def show
    @search = TunesTakeoutWrapper.search(params[:term])
    @music = Music.music(@search)
    @restaurant_id_array = Food.restaurant_id_array(@search)
    @music = reject_playlists(@music)
    @music_stuff = []
    @restaurants = Food.restaurant_instances(@restaurant_id_array)
    @music.each do |id, type|
      @music_stuff << Music.music_search(id, type)
    end
    @music_stuff.first
    @pairings = @music_stuff.zip(@restaurants)



  end

  def reject_playlists(music_array)
    music_array.reject do |id, type|
      type == "playlist"
    end
  end

end
