class PersonShim
  attr_accessor :id, :start, :gender, :team
  def initialize person
    self.id = person.id
    self.start = person.start
    self.gender = person.gender
    self.team = person.team
  end

  def attributes
    {start: start, gender: gender, team: team}
  end
end
