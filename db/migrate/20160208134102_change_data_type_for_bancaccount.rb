class ChangeDataTypeForBancaccount < ActiveRecord::Migration
  def change
  change_column :companies, :bankaccount, :integer, :limit => 8 ##для litesql было лимит 20
  end
end
