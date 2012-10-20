class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :project_id
      t.string :description, :name
      t.timestamps
    end
    add_index :sprints, :project_id
  end
end
