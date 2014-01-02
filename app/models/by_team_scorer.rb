class ByTeamScorer
  def self.score people_arrays
    ByPersonalAttributeScorer.score people_arrays, team
  end

  def self.team; 'team'; end
end