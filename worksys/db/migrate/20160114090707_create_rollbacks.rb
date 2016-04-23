class CreateRollbacks < ActiveRecord::Migration
  def change
    create_table :rollbacks do |t|

      t.timestamps null: false
    end
  end
end
