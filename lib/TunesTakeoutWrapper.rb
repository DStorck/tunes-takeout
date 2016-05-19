require "httparty"
module TunesTakeoutWrapper
BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query="
FAV_URL = "https://tunes-takeout-api.herokuapp.com/"

  def self.search(term, limit = 5)
    @search_term = term
    @limit = limit
    @response = HTTParty.get(BASE_URL + "#{@search_term}" + "&limit="+ "#{@limit}")
  end

  def self.top_twenty
    @initial_response = HTTParty.get("http://tunes-takeout-api.herokuapp.com/v1/suggestions/top?limit=20")
    return "" if @initial_response.nil?
    @tat_ids = @initial_response["suggestions"]
    @top_pairings = []
    @tat_ids.each do |suggestion_id|
      @top_pairings << HTTParty.get(FAV_URL + "/v1/suggestions/" + "#{suggestion_id}")
    end
    @top_twenty_array_of_hashes = []
    @top_pairings.each do |info|
      @top_twenty_array_of_hashes << info['suggestion']
    end
    @top_twenty_array_of_hashes
  end

  def self.favorite(userid , id)
    HTTParty.post(FAV_URL + "/v1/users/#{userid}/favorites", body: { "suggestion": "#{id}" }.to_json )
  end

end
