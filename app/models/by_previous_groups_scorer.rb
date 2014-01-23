class ByPreviousGroupsScorer < ScorerLoop
  def self.score people_arrays
    groups = recent_groups
    all_people = people_arrays.flatten.uniq
    people_to_previous_group_members = previous_group_members_for all_people, recent_groups
    score_loop(people_arrays) do
      |people| score_people(people, people_to_previous_group_members) / people.length
    end
  end

  private
    def self.score_people people, people_to_previous_group_members
      already_scored = []
      people.map do |person|
        already_scored << person
        to_score = people - already_scored
        score_person person, to_score, people_to_previous_group_members[person]
      end.reduce :+
    end

    def self.score_person person, other_people, previously_in_groups
      score = other_people.map do |other_person|
        included = previously_in_groups.include? other_person
        included ? 0.0 : 1.0
      end.reduce 0.0, :+
    end

    def self.recent_groups
      recent_events = Event.last(4)
      recent_events.flat_map(&:groups)
    end

    def self.previous_group_members_for people, groups
      people_to_previous_group_members = {}
      people.each do |person|
        groups_including_person = groups.find_all {|group| group.people.include? person}
        previous_group_members = groups_including_person.map(&:people).flatten.uniq
        people_to_previous_group_members[person] = previous_group_members
      end
      people_to_previous_group_members
    end
end