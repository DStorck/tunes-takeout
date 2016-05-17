require 'rspotify'

class Music < ActiveRecord::Base
  attr_reader :item_id, :type, :name, :url, :image_url #type can be album, track, artist,playlist

  def initialize(data)
    @item_id = data[:id]
    @type = data[:name]
    @name = data[:url]
    @url = data[:image_url]
    @image_url = data[:phone]
  end

  def self.music(response) #move this to music model
    @music_info = response["suggestions"]
    @music_array = []
    @music_info.map do |music|
      @music_array << [music["music_type"], music["music_id"]]
    end
    @music_array.first
  end

  def self.music_search(type, id)  #move this to music model
    case type
    when "album" then search = RSpotify::Album.find(id)
    when "track" then search = RSpotify::Track.find(id)
    when "playlist" then search = RSpotify::Playlist.find(id)
    when "artist" then search = RSpotify::Artist.find(id)
    end
    search
  end

end
