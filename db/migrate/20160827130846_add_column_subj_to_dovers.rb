class AddColumnSubjToDovers < ActiveRecord::Migration
  def change
    add_column :dovers, :subj, :string
  end
end
