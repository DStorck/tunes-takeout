require 'yelp'
require_relative "../../lib/TunesTakeoutWrapper"

class SuggestionsController < ApplicationController

  def show
    @search = TunesTakeoutWrapper.search(params[:term], params[:limit])
    @music = Music.create_music_array(@search)
    @restaurant_id_array = Food.restaurant_id_array(@search)
    # @music = reject_playlists(@music)
    @music_stuff = []
    @restaurants = Food.restaurant_instances(@restaurant_id_array)
    @music.each do |id, type|
      @music_stuff << Music.music_search(id, type)
    end
    # @music_stuff.first
    @pairings = @music_stuff.zip(@restaurants)
    @favorites = TunesTakeoutWrapper.favorite_ids(current_user.uid)
  end

  def index
    @top_twenty = TunesTakeoutWrapper.top_twenty
    @top_pairings = []
    @top_twenty.each do |suggestion|
      restaurant = Food.find_restaurant(suggestion["food_id"])
      music = Music.music_search(suggestion["music_type"], suggestion["music_id"])
      @top_pairings << [music, restaurant, suggestion["id"]]
    end
    @top_pairings
    @favorites = TunesTakeoutWrapper.favorite_ids(current_user.uid)

  end

  def favorite
    TunesTakeoutWrapper.favorite(current_user.uid, params[:id])
    redirect_to root_path
  end



  def reject_playlists(music_array)
    music_array.reject do |id, type|
      type == "playlist"
    end
  end

end
