class ChangeColumnTypeOfTreolans < ActiveRecord::Migration
  def change
  change_column :treolans, :transit, :string
  change_column :treolans, :quantity, :string
  end
end
