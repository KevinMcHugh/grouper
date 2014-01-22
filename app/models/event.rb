class Event < ActiveRecord::Base
  has_many :groups

  def inspect; "#{name} with #{groups}"; end

  def == other
    equal_names = other.name == name
    equal_groups = (other.groups - groups) && (groups - other.groups)
    equal_names && equal_groups
  end
end
