class ChangeDataTypeForInnKpp < ActiveRecord::Migration
  def change
  change_column :companies, :inn, :integer, :limit => 8
  change_column :companies, :kpp, :integer, :limit => 8
  end
end
