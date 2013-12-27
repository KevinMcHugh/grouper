class ByStartDateScorer < ScoreTransformer
  def self.score groups 
    group_distance_mapping = map_distances groups
    group_score_mapping = score_distances group_distance_mapping
    transform group_score_mapping
  end

  private
    def self.map_distances groups
      group_distance_mapping = {}
      groups.each do |group|
        distance = (group[0].start - group[1].start).abs
        group_distance_mapping[group] = distance
      end
      group_distance_mapping
    end
end