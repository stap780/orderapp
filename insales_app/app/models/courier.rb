class Courier < ActiveRecord::Base

validates :number, uniqueness: true

	has_many :iorders


end
