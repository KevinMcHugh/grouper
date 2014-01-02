class ByTeamScorer < ScoreTransformer
  def self.score groups
    group_distance_mappings = {}
    groups.each do |group|
      teams = group.map {|person| person.team}.uniq
      score = teams.length.to_f / group.length
      group_distance_mappings[group] = score
    end
    transform score_distances(group_distance_mappings)
  end
end