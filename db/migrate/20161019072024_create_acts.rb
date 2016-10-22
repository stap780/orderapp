class CreateActs < ActiveRecord::Migration
  def change
    create_table :acts do |t|
      t.integer :company_id
      t.date :startdate
      t.date :enddate

      t.timestamps null: false
    end
  end
end
