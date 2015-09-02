class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_index :users, :provider
    add_column :users, :uid, :string
    add_index :users, :uid
    remove_column :users, :username, :string
    remove_column :users, :twitter_uid, :string
  end
end
