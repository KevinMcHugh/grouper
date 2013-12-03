class Person < ActiveRecord::Base

	def man?; gender.to_sym.eql? :man; end
	def woman?; gender.to_sym.eql? :woman; end

end
