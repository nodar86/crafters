class ChangeBodyToTextInNews < ActiveRecord::Migration[5.0]
  def up
    change_column :news, :body, :text
  end
  def down
    change_column :news, :body, :string
  end
end
