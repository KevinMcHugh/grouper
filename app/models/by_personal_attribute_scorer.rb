class ByPersonalAttributeScorer < ScorerLoop
  def self.score groups, attribute
    score_loop(groups) do |people|
      attributes = people.map {|person| person.attributes[attribute]}.uniq
      attributes.length.to_f / people.length
    end
  end
end