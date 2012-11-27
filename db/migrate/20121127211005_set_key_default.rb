class SetKeyDefault < ActiveRecord::Migration
  def change
    change_column :songs, :key, :string, default: "CM"
  end
end
