class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :access_token, :string
    add_column :users, :verified, :boolean, default: false
  end
end
