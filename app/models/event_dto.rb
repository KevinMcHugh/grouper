# A convenient class for displaying events.
class EventDTO
  def initialize event
    @event = event
  end

  def group_table
    if !@event.groups.empty?
      group_text = @event.groups.map.with_index(1) do |group, int|
        ["Group #{int}"] + group.to_s
      end
      max_size = group_text.max_by {|string| string.size}.size
      group_text.each {|r| r[max_size - 1] ||= nil }
      group_text.transpose
    end
  end

  def people; @event.people; end
  def name; @event.name; end
  def id; @event.id; end
end