class AddAdressAndClientColumnsToIorders < ActiveRecord::Migration
  def change
  	add_column :iorders, :client_middlename, :string
  	add_column :iorders, :client_surname, :string
  	add_column :iorders, :shipping_zip, :integer
  	add_column :iorders, :shipping_city, :string 
  	add_column :iorders, :shipping_address, :string
  end
end
