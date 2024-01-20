class CreatePrivacies < ActiveRecord::Migration[7.0]
  def change
    create_table :privacies do |t|
      t.integer :privacy
      t.integer :event_id
 
      t.timestamps
    end
  end
end
