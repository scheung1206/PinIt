class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.references :user

      t.timestamps
    end

    add_column :pins, :album_id, :integer
  end
end
