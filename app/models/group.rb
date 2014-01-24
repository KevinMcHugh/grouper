class Group < ActiveRecord::Base
  belongs_to :event
  has_and_belongs_to_many   :people

  def == other
    eql_events = other.event == event
    eql_people = (other.people - people) == (people - other.people)
    eql_events && eql_people
  end

  def inspect; people.map &:to_s; end
  alias_method :to_s, :inspect
end
