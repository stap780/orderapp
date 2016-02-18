class CreateClientsCompanies < ActiveRecord::Migration
  def change
    create_table :clients_companies, id: false do |t|
		t.integer :client_id
		t.integer :company_id
    end
    add_index :clients_companies, :client_id
    add_index :clients_companies, :company_id
    
    remove_column :companies, :client_id
  end
  
end
