require("minitest/autorun")
require("minitest/rg")

require_relative("../guest.rb")
require_relative("../song.rb")
require_relative("../room.rb")

class GuestTest < MiniTest::Test

  def setup
    @song1= Song.new("Cyndi Lauper", "Girls Just Wanna Have Fun")
    @song5= Song.new("David Bowie", "Let's Dance")

    @guest1= Guest.new("Joe", @song1, 50)
    @guest2 = Guest.new("Jim", @song2, 0)
    @room1 = Room.new("The Drunken Clam", 100, 3, 5, 2)
  end

  def test_guest_has_name
    assert_equal("Joe", @guest1.name)
  end

  def test_guest_has_favourite_song
    assert_equal(@song1, @guest1.favourite_song)
  end

  def test_guest_pays_entry
    @guest1.tries_to_pay_entry(@room1)
    assert_equal(45, @guest1.wallet)
  end

  def test_guest_cannot_afford_entry
    @guest2.tries_to_pay_entry(@room1)
    assert_equal(0, @guest2.wallet)
  end

  def test_guest_buys_song
    assert_equal(false, @room1.has_song_in_playlist(@song5))
    @guest1.buys_song(@song5, @room1)
    assert_equal(true, @room1.has_song_in_playlist(@song5)) # song added to playlist
    assert_equal(48, @guest1.wallet) # money taken from guest
    assert_equal(102, @room1.till) # money added to room till
  end

  def test_guest_cannot_buy_song_that_is_already_in_playlist
    @guest1.buys_song(@song5, @room1)
    assert_equal(true, @room1.has_song_in_playlist(@song5)) # song added to playlist
    assert_equal(48, @guest1.wallet) # money taken from guest
    assert_equal(102, @room1.till) # money added to room till
    @guest1.buys_song(@song5, @room1)
    assert_equal(true, @room1.has_song_in_playlist(@song5)) # song STILL in playlist
    assert_equal(48, @guest1.wallet) # money NOT taken
    assert_equal(102, @room1.till) # money NOT ADDED
  end

end
