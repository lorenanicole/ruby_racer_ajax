class Game < ActiveRecord::Base

  validates :name, uniqueness: true
  validate :num_players

  def num_players
    if !self.players.count == 2
      errors.add(:players_count, "Each game must have two players")
    end
  end


  has_many :rounds
  has_many :players, through: :rounds
  # Remember to create a migration!
end
