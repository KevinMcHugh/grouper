class ExperimentalByPreviousGroupsScorer < ByPreviousGroupsScorer

  def self.recent_groups
    recent_events = Event.last(4)
    recent_events.flat_map(&:groups).map(&:to_shim)
  end
end
