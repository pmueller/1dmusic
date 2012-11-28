class ChangeCurrentToText < ActiveRecord::Migration
  def up
    change_column :generations, :current, :text
  end

  def down
    change_column :generations, :current, :string
  end
end
