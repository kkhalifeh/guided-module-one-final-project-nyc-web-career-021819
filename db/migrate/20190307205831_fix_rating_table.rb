class FixRatingTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :ratings, :beer_id
    add_column :ratings, :beer_id, :integer
  end
end
