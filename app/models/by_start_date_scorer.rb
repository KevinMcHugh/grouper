class ByStartDateScorer < ScorerLoop
  def self.score people_arrays
    score_loop(people_arrays) do |people|
      score_people(people).to_f / people.length
    end
  end

  private
    def self.score_people people
      start_dates = people.map {|person| person.start }.sort
      distances = (0..start_dates.length-2).map do |i|
        start_dates[i+1] - start_dates[i]
      end
      distances.reduce :+
    end
end