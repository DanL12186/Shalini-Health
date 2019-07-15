class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :prep_time
      t.string :ingredients, array: true, default: []
      t.string :image_name
      t.string :description
      t.string :directions
    end
  end
end
