class AddDetailsToFood < ActiveRecord::Migration
  def change
    add_column :foods, :business_id, :string
    add_column :foods, :name, :string
    add_column :foods, :address, :string
    add_column :foods, :city, :string
    add_column :foods, :phone, :string
    add_column :foods, :rating_url, :string
    add_column :foods, :image, :string

  end
end
