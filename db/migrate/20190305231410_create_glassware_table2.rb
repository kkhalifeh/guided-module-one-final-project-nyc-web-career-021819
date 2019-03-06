class CreateGlasswareTable2 < ActiveRecord::Migration[5.0]
  def change
    create_table :glasswares do |t|
      t.string :name
      t.string :shortname
      t.integer :glasswareId
    end
  end
end
