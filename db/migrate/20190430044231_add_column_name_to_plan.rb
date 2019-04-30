class AddColumnNameToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :major, :reference
  end
end
