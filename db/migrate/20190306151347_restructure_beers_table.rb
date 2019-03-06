class RestructureBeersTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :beers, :description
    remove_column :beers, :abv
    remove_column :beers, :styleId
    remove_column :beers, :glasswareId
    add_column :beers, :abv, :float
    add_column :beers, :glassware, :string
    add_column :beers, :style, :string
    add_column :beers, :strength, :string
  end
end
