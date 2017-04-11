class CreateKurs < ActiveRecord::Migration
  def change
    create_table :kurs do |t|
      t.datetime :date
      t.integer :dollar
      t.integer :euro

      t.timestamps null: false
    end
  end
end
