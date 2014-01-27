# People, they have names, start( dates), genders, teams.
# There should be many teams, and perhaps with tenure checked.
class Person < ActiveRecord::Base

  has_and_belongs_to_many :groups
  def inspect; "#{name}:#{id}"; end
  def to_s; name; end

  def == other_person
    #TODO: should check team.
    names = other_person.name == name
    genders = other_person.gender.to_sym == gender.to_sym
    starts = other_person.start == start
    names && genders && starts
  end
end
