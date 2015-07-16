class CreateComicsTable < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name, null: false
      t.string :api_key, null: false
    end
  end
end
