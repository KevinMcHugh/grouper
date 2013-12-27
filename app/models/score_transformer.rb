class ScoreTransformer
  def self.transform group_score_mapping
    result = []
    group_score_mapping.each_pair do |group, score|
      result << {group: group, score: score}
    end
    result
  end
  def self.score_distances group_distance_mapping
      greatest_distance = group_distance_mapping.values.max
      group_score_mapping = {}
      group_distance_mapping.keys.each do |group|
        group_score_mapping[group] = group_distance_mapping[group] / greatest_distance
      end
      group_score_mapping
  end
end