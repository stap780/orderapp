#!/bin/env ruby
# encoding: utf-8
class Treolan < ActiveRecord::Base

require 'roo'
require 'roo-xls'

has_many :products

validates :sku, uniqueness: true

def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |homyproduct|
        csv << homyproduct.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.import(file)
        spreadsheet = open_spreadsheet(file) 
     (5..spreadsheet.last_row).each do |i|  
       treolan = find_by_title("sku") || new
	     sku = spreadsheet.cell(i,'A') 
	     title = spreadsheet.cell(i,'B')    
	     quantity = spreadsheet.cell(i,'D').to_s.gsub(/много/, '30').gsub(/мало/, '10')
	     #transit = spreadsheet.cell(i,'E')
	 
	     price = spreadsheet.cell(i,'G')
		 
      treolan.update_attributes(:sku => sku, :title => title, :price => price, :quantity => quantity)
      treolan.save
      
          
      treolans = Treolan.where("sku = ?", spreadsheet.cell(i,'A'))
      treolans.each do |tr|
      tr.update_attributes(:sku => sku, :title => title, :price => price, :quantity => quantity)
      end
       
    end
    
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
