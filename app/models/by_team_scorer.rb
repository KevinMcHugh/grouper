# Score based on team.
# TODO: there should be multiple teams
class ByTeamScorer < ByPersonalAttributeScorer
  def self.attribute; 'team'; end
end