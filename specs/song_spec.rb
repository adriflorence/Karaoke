require("minitest/autorun")
require("minitest/rg")

require_relative("../song.rb")

class SongTest < MiniTest::Test

  def setup
    @song1= Song.new("Cyndi Lauper", "Girls Just Wanna Have Fun")
  end

  def test_song_has_performer
    assert_equal("Cyndi Lauper", @song1.performer)
  end

  def test_song_has_title
    assert_equal("Girls Just Wanna Have Fun", @song1.title)
  end

end
