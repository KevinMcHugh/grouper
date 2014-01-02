class ByGenderScorer
  def self.score people_arrays
    ByPersonalAttributeScorer.score people_arrays, gender
  end

  def self.gender; 'gender'; end
end