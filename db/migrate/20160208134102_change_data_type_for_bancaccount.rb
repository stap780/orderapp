class ChangeDataTypeForBancaccount < ActiveRecord::Migration
  def change
  change_column :companies, :bankaccount, :integer, :limit => 20
  end
end
