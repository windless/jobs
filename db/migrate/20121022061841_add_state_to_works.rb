class AddStateToWorks < ActiveRecord::Migration
  def change
    add_column :works, :state, :string, default: "uncheck"
  end
end
