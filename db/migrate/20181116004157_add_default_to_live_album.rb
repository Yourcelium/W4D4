class AddDefaultToLiveAlbum < ActiveRecord::Migration[5.2]
  def change
    change_column :albums, :live, :boolean, default: false, null: false
  end
end
