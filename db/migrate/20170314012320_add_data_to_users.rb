class AddDataToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :FirstName, :string
  	add_column :users, :LastName, :string
  	add_column :users, :Bio, :string
  end
end
