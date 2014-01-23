class Person < ActiveRecord::Base

  has_and_belongs_to_many :groups
  def man?; gender.to_sym.eql? :man; end
  def woman?; gender.to_sym.eql? :woman; end
  def inspect; "#{name}-#{team}-#{gender}-#{start}-#{groups}"; end
  def to_s; inspect; end

  def == other_person
    return false if other_person.class != self.class
    names = other_person.name == name
    genders = other_person.gender == gender
    starts = other_person.start == start
    names && genders && starts
  end
end
