class AddIsOnWhitelistToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :isonwhitelist, :boolean, default: false
  end
end
