class AddUidAndProviderToUser < ActiveRecord::Migration
  def change
  	change_table(:users) do |t|
       t.string   :provider
       t.string :uid
     end
     add_index "users", ["email", "provider", "uid"], :name => "index_users_on_identity", :unique => true
  end
end
