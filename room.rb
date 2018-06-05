require('pry')

class Room

  attr_reader :name, :capacity, :entry, :song_price
  attr_accessor :guest_list, :playlist, :till

  def initialize(name, till, capacity, entry, song_price)
    @name = name
    @guest_list = []
    @playlist = []
    @capacity = capacity
    @entry = entry
    @song_price = song_price
    @till = till
  end

  def check_in_guest(guest)
    if @guest_list.length < capacity
      @guest_list << guest
      till_update(@entry)
    end
  end

  def check_out_guest(guest_to_find)
    for guest in @guest_list
      if guest == guest_to_find
        @guest_list.delete(guest)
      end
    end
  end

  def is_guest_in_the_room(guest_to_find)
    binding.pry
    for guest in @guest_list
      if guest == guest_to_find
        return true
      end
    end
    return false
  end

  def number_of_people_in_room
    return @guest_list.length
  end

  def return_guest_list
    return @guest_list
  end

  def add_song(song)
    @playlist << song
  end

  def has_song_in_playlist(song_to_find)
    for song in @playlist
      if song == song_to_find
        return true
      end
    end
    return false
  end

  def guest_favourite_song_on_playlist(guest)
    if has_song_in_playlist(guest.favourite_song)
      guest.cheers()
    end
  end

  def till_update(amount)
    @till += amount
  end

end
