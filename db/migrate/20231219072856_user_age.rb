class UserAge < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :region_id, :integer

    add_column :users, :gender, :integer
    
    add_column :users, :age, :integer

  end
end
