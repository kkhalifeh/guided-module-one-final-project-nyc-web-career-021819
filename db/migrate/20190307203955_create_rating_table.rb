class CreateRatingTable < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.string :beer_id
      t.integer :beer_rating
    end
  end
end
