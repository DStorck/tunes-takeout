require "httparty"
module TunesTakeoutWrapper
BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query="

  def self.search(term)
    @search_term = term
    @response = HTTParty.get(BASE_URL + "#{@search_term}" + "&limit=3&seed=banana")
  end

  




end
