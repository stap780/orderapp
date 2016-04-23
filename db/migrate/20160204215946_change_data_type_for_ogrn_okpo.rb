class ChangeDataTypeForOgrnOkpo < ActiveRecord::Migration
  def change
   change_column :companies, :ogrn, :integer, :limit => 8
  change_column :companies, :okpo, :integer, :limit => 8
   change_column :companies, :bik, :integer, :limit => 8
  change_column :companies, :bankaccount, :integer, :limit => 8
  end
end
