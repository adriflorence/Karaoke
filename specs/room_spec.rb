require("minitest/autorun")
require("minitest/rg")
require('pry')

require_relative("../guest.rb")
require_relative("../song.rb")
require_relative("../room.rb")

class RoomTest < MiniTest::Test

  def setup
    @song1 = Song.new("Cyndi Lauper", "Girls Just Wanna Have Fun")
    @song2 = Song.new("Baltimora", "Tarzan Boy")
    @song3 = Song.new("Erasure", "Always")
    @song4 = Song.new("Dexys Midnight Runners", "Come On Eileen")
    @guest1 = Guest.new("Joe", @song1, 20)
    @guest2 = Guest.new("Jim", @song2, 0)
    @guest3 = Guest.new("Jack", @song3, 10)
    @guest4 = Guest.new("John", @song4, 20)
    @guest4 = Guest.new("Jen", @song4, 5)
    @room1 = Room.new("The Drunken Clam", 100, 3, 5, 2) # till, capacity, entry, song price
  end

  def test_room_has_name
    assert_equal("The Drunken Clam", @room1.name)
  end

  def test_guest_checked_into_room
    @room1.check_in_guest(@guest1)
    assert_equal(1, @room1.number_of_people_in_room())
  end

  def test_room_is_too_crowded_checkin_fail
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest2) # NOT CHECKED IN
    @room1.check_in_guest(@guest3)
    @room1.check_in_guest(@guest4)
    assert_equal(3, @room1.number_of_people_in_room())
  end

  def test_guest_checked_out_of_room
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest2)
    @room1.check_out_guest(@guest1)
    assert_equal(false, @room1.is_guest_in_the_room(@guest1))
    assert_equal(true, @room1.is_guest_in_the_room(@guest2))
  end

  def test_return_guest_list
    p @room1.return_guest_list()
  end

  def test_room_has_song_in_playlist
    @room1.add_song(@song1)
    assert_equal(true, @room1.has_song_in_playlist(@song1))
    assert_equal(false, @room1.has_song_in_playlist(@song2))
  end

  def test_guest_favourite_song_on_playlist
    @room1.check_in_guest(@guest2) # fav song is song2
    @room1.add_song(@song2)
    assert_equal("WHOOP! WHOOP!", @room1.guest_favourite_song_on_playlist(@guest2))
  end

  def test_till_updates
    @room1.till_update(5)
    assert_equal(105, @room1.till)
  end

  def test_lost_of_people_arrive
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest2) # NOT CHECKED IN
    @room1.check_in_guest(@guest3)
    @room1.check_in_guest(@guest4)
    @room1.check_in_guest(@guest5) # NOT CHECKED IN
    assert_equal(115, @room1.till)
    @guest1.buys_song(@song5, @room1)
    @guest1.buys_song(@song5, @room1) # cannot be bought twice
    assert_equal(117, @room1.till)
  end

end
