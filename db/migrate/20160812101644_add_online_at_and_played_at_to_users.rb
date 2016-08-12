class AddOnlineAtAndPlayedAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :online_at, :datetime
    add_column :users, :played_at, :datetime
  end
end
