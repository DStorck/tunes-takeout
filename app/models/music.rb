require 'rspotify'

class Music < ActiveRecord::Base
  attr_reader :item_id, :type, :name, :url, :image_url #type can be album, track, artist,playlist

  def initialize(data)
    # @item_id = data[:id]
    # @type = data[:name]
    @name = data.name
    # @url = data[:image_url]
    # @image_url = data[:phone]
  end

  def self.music(response) #move this to music model
    @music_info = response["suggestions"]
    @music_array = []
    @music_info.map do |music|
      @music_array << [music["music_type"], music["music_id"]]
    end
    @music_array
  end


  def self.music_search(type, id)  #move this to music model
    case type
    when "album" then search = RSpotify::Album.find(id)
    when "track" then search = RSpotify::Track.find(id)
    when "artist" then search = RSpotify::Artist.find(id)
    end
    search
  end

  private

  def reject_playlists(music_array)
    music_array.reject do |id, type|
      type == "playlist"
    end
  end
  # embed into paage to play it     https://play.spotify.com/track/2hitsKa8SthKhRJBXUHbIv

end
