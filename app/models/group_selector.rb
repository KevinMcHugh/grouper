class GroupSelector
  def self.select people
    scores = get_scores people
    to_place = people
    groups = []
    first_group = scores.last[:group]
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
      combine(flat_scores).sort_by {|s| s[:score]}
    end

    def self.combine flat_scores
      grouped_scores = flat_scores.group_by {|s| s[:group]}
      grouped_scores.values.map do |score_mappings|
        score_mappings.reduce do |a, i|
          {group: a[:group], score: (a[:score] + i[:score])}
        end
      end
    end

    def self.add_to_groups_and_remove_from_to_place group, groups, to_place
      clone = group.clone
      groups << clone
      to_place.delete_if {|p| clone.include? p }
    end

    def self.next_group scores, to_place
      group = scores.find { |g| (g[:group] - to_place).empty? }
      return group[:group] unless group.nil? || group.empty?
      to_place
    end

    def self.place groups, scores, to_place
      while !to_place.empty? do
        group = next_group scores, to_place
        add_to_groups_and_remove_from_to_place group, groups, to_place
      end
      groups.map {|g| Group.new(people: g)}
    end
    def self.group_size; 4; end
end
