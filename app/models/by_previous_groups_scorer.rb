class ByPreviousGroupsScorer < ScoreTransformer
  def self.score groups
    group_score_mappings = {}
    groups.each do |people|
      score = score_people(people) / people.length
      group_score_mappings[people] = score
    end
    transform score_distances(group_score_mappings)
  end

  private
    def self.score_people people
      already_scored = []
      people.map do |person|
        already_scored << person
        to_score = people - already_scored
        score_person person, to_score
      end.reduce :+
    end

    def self.score_person person, other_people
      previously_in_groups = person.groups.flat_map {|group| group.people}.uniq
      score = other_people.map do |other_person|
        included = previously_in_groups.include? other_person
        included ? 0.0 : 1.0
      end.reduce 0.0, :+
    end
end