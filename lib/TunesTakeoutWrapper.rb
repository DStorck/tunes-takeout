require "httparty"
module TunesTakeoutWrapper
BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query="
FAV_URL = "https://tunes-takeout-api.herokuapp.com/"

  def self.search(term)
    @search_term = term
    @response = HTTParty.get(BASE_URL + "#{@search_term}" + "&limit=3")
  end

  def self.top_twenty
    @initial_response = HTTParty.get("http://tunes-takeout-api.herokuapp.com/v1/suggestions/top?limit=20")
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

end
