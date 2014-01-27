#Scores people by who they have previously been in groups with.
# This is rather slow!
class ByPreviousGroupsScorer < ScorerLoop
  def self.score people_arrays
    people = people_arrays.flatten.uniq
    people_to_group_members = group_members_for_all people, recent_groups
    score_loop(people_arrays) do
      |people| score_people(people, people_to_group_members) / people.length
    end
  end

  private
    def self.score_people people, people_to_previous_group_members
      already_scored = []
      people.map do |person|
        already_scored << person
        to_score = people - already_scored
        score_person to_score, people_to_previous_group_members[person]
      end.reduce :+
    end

    def self.score_person other_people, previously_in_groups
      score = other_people.map do |other_person|
        included = previously_in_groups.include? other_person
        included ? 0.0 : 1.0
      end.reduce 0.0, :+
    end

    def self.recent_groups
      recent_events = Event.last(4)
      recent_events.flat_map(&:groups)
    end

    def self.group_members_for_all people, groups
      people_to_group_members = {}
      people.each do |person|
        group_members = group_members_for person, groups
        people_to_group_members[person] = group_members
      end
      people_to_group_members
    end

    def self.group_members_for person, groups
      groups_including_person = groups_including person, groups
      groups_including_person.map(&:people).flatten.uniq
    end

    def self.groups_including person, groups
      groups.find_all {|group| group.people.include? person}
    end
end