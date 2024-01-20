class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :image_id
      t.integer :privacy

      t.timestamps
      t.datetime :start_time , null: false
    end
  end
end
