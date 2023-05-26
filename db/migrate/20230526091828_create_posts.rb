class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :postal_code
      t.integer :latitude
      t.integer :longitude
      t.text :introduction

      t.timestamps
    end
  end
end
