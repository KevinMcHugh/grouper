class ByStartDateScorer < ScorerLoop
  def self.score groups 
    score_loop(groups) { |people|(people[0].start - people[1].start).abs }
  end
end