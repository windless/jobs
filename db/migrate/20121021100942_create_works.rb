class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :name, :description
      t.integer :sprint_id
      t.timestamps
    end
    add_index :works, :sprint_id
  end
end
