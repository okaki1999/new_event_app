class CreatePrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :prefectures do |t|
      t.integer :region_id
      t.integer :user_id
      t.string :prefecturename

      t.timestamps
    end
  end
end
