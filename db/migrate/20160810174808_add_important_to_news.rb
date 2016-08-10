class AddImportantToNews < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :important, :boolean
  end
end
