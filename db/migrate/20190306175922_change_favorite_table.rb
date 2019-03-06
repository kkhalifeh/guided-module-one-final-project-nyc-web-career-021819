class ChangeFavoriteTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :favorites, :trying
    remove_column :favorites, :is_favorite
  end
end
