require 'test_helper'

class MusicTest < ActiveSupport::TestCase

  describe "Music Model",  :vcr do

    it "can find track from spotify api and turn it into a music instance", :vcr do
      @new_track = Music.music_search("track", "0BjkSCLEHlcsogSeDim01W")
      assert_equal @new_track.class, Music
      assert_equal @new_track.name, "Mental Floss"
      assert_equal @new_track.type, "track"
      assert_equal @new_track.url, "https://open.spotify.com/track/0BjkSCLEHlcsogSeDim01W"
      assert_equal @new_track.uri, "spotify:track:0BjkSCLEHlcsogSeDim01W"
    end

    it "can find album from spotify api and turn it into a music instance", :vcr do
      @new_album = Music.music_search("album", "1Bg7byH7AeQhvwfXs4iRiG")
    end

    it "can find arist from spotify api and turn it into a music instance", :vcr do
      @new_artist = Music.music_search("artist", "0r2HEDK9STwKSmzmeJiAle")
    end

  end
end
