class AddSongIdToGenerationsAndRules < ActiveRecord::Migration
  def change
    add_column :rules, :song_id, :integer
    add_column :generations, :song_id, :integer
  end
end
