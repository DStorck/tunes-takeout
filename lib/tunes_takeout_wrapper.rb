require "httparty"
module TunesTakeoutWrapper
BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query="
FAV_URL = "https://tunes-takeout-api.herokuapp.com/"

  def self.search(term, limit = 5)
    @search_term = term
    @limit = limit
    @response = HTTParty.get(BASE_URL + "#{@search_term}" + "&limit="+ "#{@limit}")
  end

  def self.top_twenty #returns array of music and food info
    @initial_response = HTTParty.get("http://tunes-takeout-api.herokuapp.com/v1/suggestions/top?limit=20")
    return [] if @initial_response.nil?
    @tat_ids = @initial_response["suggestions"]
    @top_twenty_array_of_hashes = self.suggestion_ids_into_info_array(@tat_ids)
  end

  def self.favorite(userid , id) #this favorites a pairing
    HTTParty.post(FAV_URL + "/v1/users/#{userid}/favorites", body: { "suggestion": "#{id}" }.to_json )
  end

  def self.favorite_ids(userid) #collects favorite ids
    @response = HTTParty.get(FAV_URL + "/v1/users/#{userid}/favorites")
    @favorites = @response["suggestions"]
  end

  def self.suggestion_ids_into_info_array(sug_id_array) #turns suggestion ids into hashes of food and music info
    @info = []
    sug_id_array.each do |suggestion_id|
      @info << HTTParty.get(FAV_URL + "/v1/suggestions/" + "#{suggestion_id}")
    end
    @array_of_hashes = []
    @info.each do |info|
      @array_of_hashes << info['suggestion']
    end
    @array_of_hashes
  end

end
