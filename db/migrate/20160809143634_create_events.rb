class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.boolean :groupEvent
      t.integer :maxPlayers
      t.integer :playersInGroup
      t.datetime :startDate

      t.timestamps
    end
  end
end
