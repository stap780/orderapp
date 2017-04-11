class ChangeKurToFloat < ActiveRecord::Migration
  def change
    change_column :kurs, :dollar, :float
    change_column :kurs, :euro, :float
  end
end
