class ChangeBeerColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :beers, :abv, :string
    add_column :beers, :foodPairings, :string
    add_column :beers, :glasswareId, :integer
    add_column :beers, :styleId, :integer
    remove_column :beers, :style
  end
end
