class AlbumPin < ApplicationRecord
  belongs_to :album
  belongs_to :pin

  validates_uniqueness_of :pin_id, :scope => :album_id
end
