class ChangeBodyToTextInNews < ActiveRecord::Migration[5.0]
  def change
    change_column :news, :body, :text
  end
end
