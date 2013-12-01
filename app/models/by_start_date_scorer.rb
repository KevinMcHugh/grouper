class ByStartDateScorer
	def self.score group, people
		largest_sum = nil
		sums = people.sort_by {|p| p.start }.map do |p|
			sum = group.map do |g| 
				(g.start - p.start).abs
			end.reduce(:+)/group.size
			{person: p, score: sum  }
		end
		largest_sum = sums.map {|score| score[:score]}.sort.last
		sums.map do |score| 
			score[:score] = score[:score] / largest_sum
			score
		end
	end
end