class YTlinktoPin < ActiveRecord::Migration[5.0]
  def change
    add_column :pins, :ytlink, :string
  end
end
