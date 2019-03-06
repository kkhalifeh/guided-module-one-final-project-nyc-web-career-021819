class CreateGlasswareTable < ActiveRecord::Migration[5.0]
  def change
    create_table :glasswares, id: false do |t|
      t.string :name
      t.integer :glasswareId
    end
  end
end
