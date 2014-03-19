class GroupCreator
  LOGGER = Logger.new(Rails.root.join('log','group_creation.log'))
  def self.logger
    LOGGER
  end

  def self.log_time method, &block
    now = Time.now
    block.yield
    logger.info "#{method} in #{Time.now - now}"
  end

  def self.with_people_shims event
    log_time("person shims") do
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

  def self.with_group_shims event
    DevelopmentProfiler::prof("groupshims") do
      log_time("group shims ") do
        all_people = event.people.to_a
        shims = all_people.map {|p| p.to_shim }
        group_shims = GroupSelector.select shims, ExperimentalGroupScorer
        groups = group_shims.map do |group|
          group.map {|p| Person.find p.id}
        end
        groups = event.add_groups groups
        groups.map &:save
      end
    end
  end

  def self.old event
    DevelopmentProfiler::prof("oldstyle") do
      log_time("old") do
        groups = GroupSelector.select(event.people.to_a)
        groups = event.add_groups groups
        groups.map &:save
      end
    end
  end

  def self.both event
    logger.info "====================================================="
    with_people_shims event
    with_group_shims event
    # old event
  end

  def self.log earlier, step
    now = Time.now
    logger.info "done with #{step} in #{now - earlier}"
    now
  end
end
