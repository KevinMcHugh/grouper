class ByGenderScorer
  def self.score groups
    ByPersonalAttributeScorer.score groups, gender
  end

  def self.gender; 'gender'; end
end