class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :to_match
      t.string :new_cell

      t.timestamps
    end
  end
end
