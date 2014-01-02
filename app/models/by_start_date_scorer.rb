class ByStartDateScorer < ScorerLoop
  def self.score people_arrays 
    score_loop(people_arrays) { |people|(people[0].start - people[1].start).abs }
  end
end