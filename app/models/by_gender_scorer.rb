class ByGenderScorer
	def self.score group, people
		man_score = 1 - group.find_all{|p| p.man?}.length/group.length
		woman_score = 1 - group.find_all{|p| p.woman?}.length/group.length
		scores = {man: man_score, woman: woman_score, trans: 1}
		people.map do |p|
			{person: p, score: scores[p.gender]}
		end
	end
end