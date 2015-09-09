class AddIndexOnNickname < ActiveRecord::Migration
  def change
  	add_index "users", ["nickname"], :name => "index_users_on_nickname", :unique => true
  end
end
