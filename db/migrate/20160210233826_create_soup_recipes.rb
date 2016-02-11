class CreateSoupRecipes < ActiveRecord::Migration
  def change
    create_table :soup_recipes do |t|
      t.string :veggie_1
      t.string :veggie_2
      t.string :broth
      t.string :spice_1
      t.string :spice_2
      t.string :spice_3

      t.timestamps null: false
    end
  end
end
