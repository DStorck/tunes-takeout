class AddUritoMusic < ActiveRecord::Migration
  def change
    add_column :musics, :uri, :string
  end
end
