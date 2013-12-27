class ScoreTransformer
  def self.transform group_score_mapping
    result = []
    group_score_mapping.each_pair do |group, score|
      result << {group: group, score: score}
    end
    result
  end
end