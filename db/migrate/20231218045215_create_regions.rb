class CreateRegions < ActiveRecord::Migration[7.0]
  def change
    create_table :regions do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :regionname
      t.string :prefecture_id

      t.timestamps
    end
  end
end
