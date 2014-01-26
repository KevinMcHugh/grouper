class Event < ActiveRecord::Base
  has_many :groups
  has_and_belongs_to_many :people

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

  def add_people people_to_add
    people_to_add.each {|person| add_person person}
  end

  def add_groups new_groups
    self.groups = new_groups
    self.groups.map { |group| group.event = self }
  end

  def remove_person person
    temp_people = people.to_a
    temp_people.delete_if {|p| p == person}
    self.people = temp_people
  end

  def == other
    equal_names = other.name == name
    equal_groups = (other.groups - groups) && (groups - other.groups)
    equal_names && equal_groups
  end

  def inspect; "#{name}-#{groups.flat_map(&:to_s)}"; end
  alias_method :to_s, :inspect
end
