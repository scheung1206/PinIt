class CreateAlbumPins < ActiveRecord::Migration[5.0]
  def change
    create_table :album_pins do |t|
      t.references :album
      t.references :pin

      t.timestamps
    end
  end
end
