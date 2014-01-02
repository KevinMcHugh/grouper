class ByPersonalAttributeScorer < ScoreTransformer
  def self.score groups, attribute
    group_distance_mappings = {}
    groups.each do |group|
      attributes = group.map {|person| person.attributes[attribute]}.uniq
      group_distance_mappings[group] = attributes.length.to_f / group.length
    end
    transform score_distances(group_distance_mappings)
  end
end