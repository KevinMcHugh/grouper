class ByPreviousGroupsScorer
	def self.score groups
		group_score_mappings = {}
		groups.each do |people|
			score = score_people(people) / people.length
			group_score_mappings[people] = score
		end
		ScoreTransformer.transform group_score_mappings
	end

	private
		def self.score_people people
			people.map do |person|
				score_person person, (people -[person])
			end.reduce :+
		end

		def self.score_person person, other_people
			previously_in_groups = person.groups.map {|group| group.people}.flatten.uniq
			score = other_people.map do |other_person|
				included = previously_in_groups.include? other_person
				included ? 0 : 1
			end.reduce :+
		end

end