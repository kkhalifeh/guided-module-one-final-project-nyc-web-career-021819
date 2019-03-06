class CreateStyleTable < ActiveRecord::Migration[5.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.string :shortname
      t.integer :styleId
    end
  end
end
