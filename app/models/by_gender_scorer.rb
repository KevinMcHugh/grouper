# Scores people based on gender.
class ByGenderScorer < ByPersonalAttributeScorer
  def self.attribute; 'gender'; end
end