class CreateUsercomicTable < ActiveRecord::Migration
  def change
    create_table :usercomic do |t|
      t.integer :user_id
      t.integer :comic_id
    end
  end
end
