# Generates scores for combinations of people.
# Slow. Next Improvement might be to implement a
# PeopleCombiner that doesn't generate as many
# combinations as Array#combination
class GroupSelector
  def self.select people, group_scorer=GroupScorer
    people_arrays = people.combination(group_size).to_a
    scores = group_scorer.score people_arrays
    to_place = people
    groups = []
    first_group = scores.first[:group]
    add_to_groups_and_remove_from_to_place first_group, groups, to_place
    place groups, scores, to_place
  end

  private
    def self.add_to_groups_and_remove_from_to_place group, groups, to_place
      clone = group.clone
      groups << clone
      to_place.delete_if {|person| clone.include? person }
    end

    def self.next_group scores, to_place
      group = scores.find { |score| (score[:group] - to_place).empty? }
      return group[:group] unless group.nil? || group.empty?
      to_place
    end

    def self.place groups, scores, to_place
      while !to_place.empty? do
        inner_loop groups, scores, to_place
      end
      groups
    end

    def self.inner_loop groups, scores, to_place
      if to_place.size < group_size - 1
        place_odd_people_in groups, to_place
        to_place.clear
      else
        group = next_group scores, to_place
        add_to_groups_and_remove_from_to_place group, groups, to_place
      end
    end

    def self.place_odd_people_in groups, people
      group_index = 0
      people.each do |person, index|
        groups[group_index] << person
        group_index += 1
        group_index = 0 if group_index == groups.size
      end
    end

    def self.group_size; 4; end
end
