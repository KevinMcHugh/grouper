class Person < ActiveRecord::Base

	has_many :groups, through: events
	def man?; gender.to_sym.eql? :man; end
	def woman?; gender.to_sym.eql? :woman; end

end
