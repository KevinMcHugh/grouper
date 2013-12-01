class Person < ActiveRecord::Base

	def man?; gender.eql? :man; end
	def woman?; gender.eql? :woman; end
end
