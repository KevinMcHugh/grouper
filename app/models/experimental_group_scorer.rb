class ExperimentalGroupScorer < GroupScorer
  def self.scorers
    [ByGenderScorer, ByStartDateScorer,
      ExperimentalByPreviousGroupsScorer, ByTeamScorer]
  end
end
