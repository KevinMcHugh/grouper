class GroupSelector
  def self.select people
    scores = get_scores people
    to_place = people
    groups = []
    first_group = scores.first[:group]
    add_to_groups_and_remove_from_to_place first_group, groups, to_place
    place groups, scores, to_place
  end

  private
    def self.scorers
      [ByGenderScorer, ByStartDateScorer,
        ByPreviousGroupsScorer, ByTeamScorer]
    end

    def self.get_scores people
      combinations = people.combination(group_size).to_a
      flat_scores = scorers.map do |scorer|
        scorer.score combinations
      end.flatten
      combine(group_scores(flat_scores)).sort_by {|score| -score[:score]}
    end

    def self.combine grouped_scores
      grouped_scores.values.map do |score_mappings|
        score_mappings.reduce do |accum, iter|
          score = (accum[:score] + iter[:score])
          {group: accum[:group], score: score}
        end
      end
    end

    def self.group_scores flat_scores
      flat_scores.group_by {|score| score[:group]}
    end

    def self.add_to_groups_and_remove_from_to_place group, groups, to_place
      clone = group.clone
      groups << clone
      to_place.delete_if {|p| clone.include? p }
    end

    def self.next_group scores, to_place
      group = scores.find { |score| (score[:group] - to_place).empty? }
      return group[:group] unless group.nil? || group.empty?
      to_place
    end

    def self.place groups, scores, to_place
      while !to_place.empty? do
        if to_place.size < group_size - 1
          place_odd_people_in groups, to_place
          to_place = []
        else
          group = next_group scores, to_place
          add_to_groups_and_remove_from_to_place group, groups, to_place
        end
      end
      groups.map {|group| Group.new(people: group)}
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
