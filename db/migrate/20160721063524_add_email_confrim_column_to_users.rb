class AddEmailConfrimColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_confirmed, :boolean, :default => false
    add_column :users, :confirm_token, :string
  end
end
