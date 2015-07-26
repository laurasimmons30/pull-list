class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.string :image_url
      t.string :description
      t.integer :comic_id, null: false
      t.date :comic_release_date, null: false
    end
  end
end
