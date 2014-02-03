class CreateTables < ActiveRecord::Migration

  def change
    create_table :players do |t|
      t.string :name
      t.timestamps
    end

    create_table :games do |t|
      t.string :name
      t.timestamps
    end

    create_table :rounds do |t|
      t.integer :player_id
      t.integer :game_id
      t.boolean :winner
      t.string :winning_time
      t.timestamps
    end

    add_index(:players, :name, :unique => true)
    add_index(:games, :name, :unique => true)

    add_index(:rounds, :player_id)
    add_index(:rounds, :game_id)

  end
end
