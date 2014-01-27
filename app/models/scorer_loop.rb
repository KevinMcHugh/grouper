# Handles all the common logic for a scorer, iterating
# over all the people and then those scores into the normallized
# format expected in GroupSelector
class ScorerLoop < ScoreTransformer
  def self.score_loop people_arrays, &block
    people_distance_mappings = {}
    people_arrays.each do |people|
      people_distance_mappings[people] = block.call people
    end
    transform score_distances(people_distance_mappings)
  end
end