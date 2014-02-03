class Round < ActiveRecord::Base

  belongs_to :game
  belongs_to :player
  # Remember to create a migration!
end
