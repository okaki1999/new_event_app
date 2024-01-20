class HangeAgeColumnTypeInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :age, :string
    change_column :users, :gender, :string
  end
end
