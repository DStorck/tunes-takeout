class MusicController < ApplicationController

  def show
    @artist = RSpotify::Artist.find(params[:artist])
  end

end
