require 'yelp'
# require_relative "../../lib/TunesTakeoutWrapper"

class SuggestionsController < ApplicationController


  def show
    @search = TunesTakeoutWrapper.search(params[:term], params[:limit])
    unless @search.nil?
      @suggestions = @search["suggestions"]
      @pairings = []
      @suggestions.each do |suggestion|
        restaurant = Food.find_restaurant(suggestion["food_id"])
        music = Music.music_search(suggestion["music_type"], suggestion["music_id"])
        @pairings << [music, restaurant, suggestion["id"]]
      end
    end
    @favorites = TunesTakeoutWrapper.favorite_ids(current_user.uid) if current_user
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
    @favorites = TunesTakeoutWrapper.favorite_ids(current_user.uid) if current_user
  end

  def favorite
    TunesTakeoutWrapper.favorite(current_user.uid, params[:id])
    redirect_to favorite_path
  end

  def unfavorite
    TunesTakeoutWrapper.unfavorite(current_user.uid, params[:id])
    redirect_to favorite_path
  end


  def faves
    @fav_ids = TunesTakeoutWrapper.favorite_ids(current_user.uid)
    @faves = TunesTakeoutWrapper.suggestion_ids_into_info_array(@fav_ids)
    @favorites = []
    @faves.each do |suggestion|
      restaurant = Food.find_restaurant(suggestion["food_id"])
      music = Music.music_search(suggestion["music_type"], suggestion["music_id"])
      @favorites << [music, restaurant, suggestion["id"]]
    end
  end



  def reject_playlists(music_array)
    music_array.reject do |id, type|
      type == "playlist"
    end
  end

end
