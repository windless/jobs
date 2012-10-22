class AddCheckerIdToWorks < ActiveRecord::Migration
  def change
    add_column :works, :checker_id, :integer
  end
end
