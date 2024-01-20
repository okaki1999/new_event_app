class Remove < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key "entries", "rooms"
    remove_foreign_key "entries", "users"
    remove_foreign_key "messages", "rooms"
    remove_foreign_key "messages", "users"
    remove_foreign_key "rooms", "users"
    remove_index "entries", column: "room_id"
    remove_index "entries", column: "user_id"
    remove_index "messages", column: "room_id"
    remove_index "messages", column: "user_id"
    remove_index "rooms", column: "user_id"
  end
end
