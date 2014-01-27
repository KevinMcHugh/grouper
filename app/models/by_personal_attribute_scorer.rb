# Scores people based on some attribute on the class,
# preferring the combinations with the greatest number of
# distinct elements
class ByPersonalAttributeScorer < ScorerLoop
  def self.score people_arrays
    score_loop(people_arrays) do |people|
      attributes = people.map {|person| person.attributes[attribute]}.uniq
      attributes.length.to_f / people.length
    end
  end
end