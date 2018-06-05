

class Guest

  attr_reader :name, :favourite_song
  attr_accessor :wallet

  def initialize(name, favourite_song, wallet)
    @name = name
    @favourite_song = favourite_song
    @wallet = wallet
  end

  def tries_to_pay_entry(room)
    if @wallet >= room.entry
      @wallet -= room.entry
    end
  end

  def cheers
    return "WHOOP! WHOOP!"
  end

  def buys_song(song, room)
    unless room.playlist.include? song
      if @wallet >= room.song_price
        @wallet -= room.song_price
        room.till_update(room.song_price)
        room.add_song(song)
      end
    end
  end

end
