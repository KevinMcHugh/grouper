class GroupShim
  attr_accessor :id, :event, :people
  def initialize group
    self.id = group.id
    self.event = group.event.id if group.event
    self.people = group.people.map &:id
  end
end
