class ByGenderScorer < ScoreTransformer
  def self.score groups
    group_distance_mapping = {}
    groups.each do |group|
      genders = group.map {|p| p.gender}.uniq
      group_distance_mapping[group] = genders.length.to_f / group.length
    end
    transform score_distances(group_distance_mapping)
  end
end