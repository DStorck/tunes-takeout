require 'yelp'

class SuggestionsController < ApplicationController

  def show
    params[:limit] = 5 if params[:limit] == ""
    params[:limit] = 20 if params[:limit].to_i > 20
    @search = TunesTakeoutWrapper.search(params[:term], params[:limit])
    unless @search.nil?
      @suggestions = @search["suggestions"]
      @pairings = turn_suggestions_into_instances(@suggestions)
    end
    @favorites = TunesTakeoutWrapper.favorite_ids(current_user.uid) if current_user
  end

  def index
    @top_twenty = TunesTakeoutWrapper.top_twenty
    @top_pairings = turn_suggestions_into_instances(@top_twenty)
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
    @favorites = turn_suggestions_into_instances(@faves)
  end

  private

  def turn_suggestions_into_instances(suggestions)
    @pairings = []
    suggestions.each do |suggestion|
      restaurant = Food.find_restaurant(suggestion["food_id"])
      music = Music.music_search(suggestion["music_type"], suggestion["music_id"])
      @pairings << [music, restaurant, suggestion["id"]]
    end
    @pairings
  end

end
