class AddInfoToMusic < ActiveRecord::Migration
  def change
    add_column :musics, :name, :string
    add_column :musics, :type, :string
    add_column :musics, :url, :string
    add_column :musics, :image_url, :string
    add_column :musics, :item_id, :string

  end
end
