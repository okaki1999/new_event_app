class Pudata < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :region_id, :integer
    
    add_column :events, :prefecture_id, :integer
    
    add_column :events, :genre_id, :integer
    
    add_column :events, :address, :string
    
    add_column :events, :latitude, :float
    
    add_column :events, :longitude, :float

  end
end