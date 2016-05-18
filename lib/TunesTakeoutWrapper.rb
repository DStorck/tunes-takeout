require "httparty"
module TunesTakeoutWrapper
BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1/suggestions/search?query="

  def self.search(term)
    @search_term = term
    @response = HTTParty.get(BASE_URL + "#{@search_term}" + "&limit=3&seed=banana")
  end

  def self.restaurants(response) #move this to food model
    @food_suggestions = response["suggestions"]
    @food_ids = @food_suggestions.map { |item| item["food_id"]}
  end

  def self.music(response) #move this to music model
    @music_info = response["suggestions"]
    @music_array = []
    @music_info.map do |music|
     @music_array << [music["music_id"], music["music_type"]]
    end
    return @music_array
  end

  def self.music_search(id, type)  #move this to music model
    case type
    when "album" then search = RSpotify::Album.find(id)
    when "track" then search = RSpotify::Track.find(id)
    when "playlist" then search = RSpotify::Playlist.find(id)
    when "artist" then search = RSpotify::Artist.find(id)
    end
    search
  end

end
