class ByTeamScorer
  def self.score groups
    ByPersonalAttributeScorer.score groups, team
  end

  def self.team; 'team'; end
end