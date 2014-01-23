class Event < ActiveRecord::Base
  has_many :groups
  has_and_belongs_to_many :people
  def inspect; "#{name} with #{groups}"; end

  after_create :copy_people_from_previous_event

  def copy_people_from_previous_event
    if people.empty?
      self.people = previous_event.people
    end
  end

  def previous_event
    previous_event = Event.last(2).first
  end

  def add_person person
    people << person unless people.include? person
  end

  def add_group group
    groups << group unless groups.include? group
    group.event = self
  end

  def == other
    equal_names = other.name == name
    equal_groups = (other.groups - groups) && (groups - other.groups)
    equal_names && equal_groups
  end

  def inspect; name; end
  def to_s; name; end
end
