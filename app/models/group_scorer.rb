class GroupScorer
   def self.scorers
      [ByGenderScorer, ByStartDateScorer,
        ByPreviousGroupsScorer, ByTeamScorer]
    end

    def self.score people_arrays
      flat_scores = scorers.map do |scorer|
        scorer.score people_arrays
      end.flatten
      combine(group_scores(flat_scores)).sort_by {|score| -score[:score]}
    end

    def self.combine grouped_scores
      grouped_scores.values.map do |score_mappings|
        score_mappings.reduce do |accum, iter|
          score = (accum[:score] + iter[:score])
          {group: accum[:group], score: score}
        end
      end
    end

    def self.group_scores flat_scores
      flat_scores.group_by {|score| score[:group]}
    end

end