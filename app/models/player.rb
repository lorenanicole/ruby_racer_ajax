class Player < ActiveRecord::Base

  validates :name, uniqueness: true

  has_many :rounds
  has_many :games, through: :rounds
  # Remember to create a migration!
  def self.add_player(player)
    found_player = Player.find_by_name(player)
    if found_player.nil?
      Player.create(name: player)
    else
      found_player
    end
  end

end
