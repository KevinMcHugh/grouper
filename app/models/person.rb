# People, they have names, start( dates), genders, teams.
# There should be many teams, and perhaps with tenure checked.
class Person < ActiveRecord::Base

  after_initialize :add_uuid
  has_and_belongs_to_many :groups
  def inspect; "#{name}:#{id}"; end
  def to_s; name; end

  def add_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def == other_person
    names = other_person.name == name
    genders = other_person.gender.to_sym == gender.to_sym
    starts = other_person.start == start
    teams = other_person.team == team
    names && genders && starts && teams
  end

  def to_shim with_groups=false
    if with_groups
      PersonShimWithGroups.new self
    else
      PersonShim.new self
    end
  end
end
