class ChangeUsercomicTableName < ActiveRecord::Migration
  def change
    rename_table :usercomic, :usercomics
  end
end
