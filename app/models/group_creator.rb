class GroupCreator

  LOGGER = Logger.new(Rails.root.join('log','group_creation.log'))
  def self.logger
    LOGGER
  end

  def self.log_time method, &block
    now = Time.now
    block.yield
    logger.info "#{method} @@@@@@@@ in #{Time.now - now}"
  end

  def self.with_people_shims event
    log_time("shims") do
      all_people = event.people.to_a
      shims = all_people.map {|p| PersonShim.new p }
      group_shims = GroupSelector.select(shims)
      groups = group_shims.map do |group|
        group.map {|p| Person.find p.id}
      end
      groups = event.add_groups groups
      groups.map &:save
    end
  end

  def self.old event
    log_time("old") do
      groups = GroupSelector.select(event.people.to_a)
      groups = event.add_groups groups
      groups.map &:save
    end
  end

  def self.both event
    logger.info "====================================================="
    with_people_shims event
    old event
  end
end
