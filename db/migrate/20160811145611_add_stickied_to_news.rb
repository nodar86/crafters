class AddStickiedToNews < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :stickied, :boolean
  end
end
