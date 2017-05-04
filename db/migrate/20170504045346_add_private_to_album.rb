class AddPrivateToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :private, :boolean, default: false
  end
end
