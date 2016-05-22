class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :business_id
      t.string :name
      t.string :address
      t.string :city
      t.string :phone
      t.string :rating_url
      t.string :image
      t.timestamps null: false
    end
  end
end
