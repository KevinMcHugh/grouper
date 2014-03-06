class PersonShimWithGroups < PersonShim

  attr_accessor :groups
  def initialize person
    super
    self.groups = person.groups.map &:to_shim
  end
end
