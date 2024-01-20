class CreateEntriesRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    create_table :entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
