#Takes scores like {[a,b] => 3.0, [b,c] => 0.0}  and returns
#[{group: [a,b], score: 1.0}, {group: [b,c], score: 0.0}] 
class ScoreTransformer
  def self.transform group_score_mapping
    result = []
    group_score_mapping.each_pair do |group, score|
      result << {group: group, score: score}
    end
    result
  end
  def self.score_distances group_distance_mapping
      old_min = group_distance_mapping.values.min
      old_max = group_distance_mapping.values.max
      old_range = old_max - old_min
      score_each_distance group_distance_mapping, old_min, old_range
  end
  private
    def self.score_each_distance group_distance_mapping, old_min, old_range
      group_score_mapping = {}
      return score_equally(group_distance_mapping) if old_range == 0
      group_distance_mapping.keys.each do |group|
        score = ((group_distance_mapping[group] - old_min) / old_range)
        group_score_mapping[group] = score
      end
      group_score_mapping
    end

    def self.score_equally group_distance_mapping
      group_score_mapping = {}
      group_distance_mapping.keys.each do |group|
        group_score_mapping[group] = 1
      end
      group_score_mapping
    end

end
