class ChangeColumnNameTypeToBanks < ActiveRecord::Migration
  def change
	  rename_column :banks, :type, :oper_type
  end
end
