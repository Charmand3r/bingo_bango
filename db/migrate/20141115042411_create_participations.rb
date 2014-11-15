class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :player
      t.references :game

      t.timestamps
    end

    add_index :participations, :player_id
    add_index :participations, :game_id
  end
end
