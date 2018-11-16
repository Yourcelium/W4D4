class CreateAlbumColumbs < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :band_id, :integer, null: false
    add_column :albums, :title, :string, null: false
    add_column :albums, :yr, :integer, null: false
    add_column :albums, :live, :boolean, null: false
   
    add_index :albums, :band_id
    add_index :albums, :title
    add_index :albums, :yr
    add_index :albums, :live
  end
end
