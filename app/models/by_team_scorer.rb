class ByTeamScorer < ScoreTransformer
  def self.score groups
    group_scoring_mappings = {}
    groups.each do |group|
      teams = group.map {|person| person.team}.uniq
      group_scoring_mappings[group] = teams.length / group.length
    end
    transform group_scoring_mappings
  end
end