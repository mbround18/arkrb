class Player
  def initialize(name, steam_id, player_id)
    @name = name
    @steam_id = steam_id
    @player_id = player_id
  end

  attr :name, :steam_id, :player_id

  def to_h
    {
        name: name,
        steam_id: steam_id,
        player_id: player_id
    }
  end

  alias_method :to_hash, :to_h

end