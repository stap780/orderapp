class Case < ActiveRecord::Base

belongs_to :client
belongs_to :iorder

	delegate :name ,:name=, to: :client, prefix: true, allow_nil: true



end
