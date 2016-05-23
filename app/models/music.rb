require 'rspotify'

class Music < ActiveRecord::Base
  attr_reader :item_id, :type, :name, :url, :image_url , :uri

  def initialize(data)
    @item_id = data.id
    @type = data.type
    @name = data.name
    @url = data.external_urls["spotify"]
    @uri = data.uri
  end


  def self.music_search(type, id)
    case type
    when "album" then search = RSpotify::Album.find(id)
    when "track" then search = RSpotify::Track.find(id)
    when "artist" then search = RSpotify::Artist.find(id)
    end
    search
    return self.new(search)
  end

end
