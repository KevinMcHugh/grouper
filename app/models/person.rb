class Person < ActiveRecord::Base

	has_and_belongs_to_many :groups
	def man?; gender.to_sym.eql? :man; end
	def woman?; gender.to_sym.eql? :woman; end

end
