class EventsUploader
  def upload yaml
    create_event parse(yaml)
  end

  def parse yaml
    values = YAML.load(yaml)
    name = values["name"]
    groups = groups_from values["groups"]
    Event.new(groups: groups, name: name)
  end

  def groups_from groups
    groups.map do |people_names|
      Group.new people: people_in(people_names)
    end
  end

  def people_in people_names
    people_names.map {|name| Person.find_by name: name }
  end

  def create_event event
    event.save
    event
  end
end