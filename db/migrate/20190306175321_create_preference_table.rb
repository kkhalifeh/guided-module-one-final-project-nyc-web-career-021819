class CreatePreferenceTable < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.string :beer_style
      t.string :beer_strength
      end
  end
end
