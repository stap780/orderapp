class Bank < ActiveRecord::Base
	
	#belongs_to :invoice
	#belongs_to :purchase_invoice
	belongs_to :payer,  :class_name => 'Company', foreign_key: "payer_id"
	belongs_to :receiver, :class_name => 'Company', foreign_key: "receiver_id"
	has_many 	 :bank_items
	has_many   :invoices, through: :bank_items
	has_many   :purchase_invoices, through: :bank_items
	accepts_nested_attributes_for :bank_items, allow_destroy: true

	
validates :number, uniqueness: true
delegate :title, :title=, to: :company, prefix: true, allow_nil: true
	
	
	 def self.import(file)
	    
    spreadsheet = open_spreadsheet(file) 
     (4..spreadsheet.last_row).each do |i|  
	     number =  spreadsheet.cell(i,'B').to_i
	     oper_type = spreadsheet.cell(i,'E')
	     sum = spreadsheet.cell(i,'D').to_f.round(2)
	     descr = spreadsheet.cell(i,'F')
	     date = spreadsheet.cell(i,'H')
	     bik = spreadsheet.cell(i,'I').to_i
	     payer_inn = spreadsheet.cell(i,'M').to_i
	     receiver_inn = spreadsheet.cell(i,'T').to_i
	     payer = Company.find_by_inn(payer_inn)
	     if payer.nil?
		     @company = Company.create(:inn => payer_inn, :title => "Обновить компанию", :bik => bik)
		     payer_id = @company.id
		   else 
	     payer_id = payer.id
	     end
	     puts "#{receiver_inn}"
	     receiver = Company.find_by_inn(receiver_inn)
				if receiver.nil?
				@company = Company.create(:inn => receiver_inn, :title => "Обновить компанию", :bik => bik)
				receiver_id = @company.id
				else 
	     receiver_id = receiver.id 
	     end
 	     @bank = Bank.find_by_number("#{number}")
 		     if @bank.nil?
		     @bank = Bank.create(:number => number, :oper_type => oper_type, :sum => sum, :description => descr, :date => date, :payer_id => payer_id, :receiver_id => receiver_id)
		     else
		     @bank.update_attributes(:oper_type => oper_type, :sum => sum, :description => descr, :date => date, :payer_id => payer_id, :receiver_id => receiver_id)
		     end
	     end
	     
	     @bank_nill = Bank.where("number = 0")
	     @bank_nill.destroy_all

  end
  
   def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {col_sep: ";"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
	
end
