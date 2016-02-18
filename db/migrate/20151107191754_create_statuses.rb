class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :number
      t.string :title
      t.string :instatus

      t.timestamps null: false
    end
    add_index :statuses, :title
  end
end
