class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.string :description, null: false
      t.integer :comic_id
      t.date :comic_release_date
    end
  end
end
