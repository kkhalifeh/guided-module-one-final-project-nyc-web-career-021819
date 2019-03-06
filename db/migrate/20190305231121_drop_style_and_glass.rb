class DropStyleAndGlass < ActiveRecord::Migration[5.0]
  def change
    drop_table :styles
    drop_table :glasswares
  end
end
