class GroupTable
  def self.create event
    group_text = event.groups.map.with_index(1) do |g, i|
        ["Group #{i}"] + g.people.map {|p| p.name}
    end
    max_size = group_text.max {|r1, r2| r1.size <=> r2.size}.size
    group_text.each {|r| r[max_size - 1] ||= nil }
    group_text.transpose
  end

end