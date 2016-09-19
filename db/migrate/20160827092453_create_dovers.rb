class CreateDovers < ActiveRecord::Migration
  def change
    create_table :dovers do |t|
      t.string :number
      t.date :startdate
      t.date :enddate
      t.integer :company_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
