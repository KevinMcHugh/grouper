class EventsUploader 
  def upload yaml
    create_event parse(yaml) 
  end

  def parse yaml
    values = YAML.load(yaml)
    name = values["name"]
    groups = values["groups"].map do |group|
      people = group.map do |name|
        Person.find_by name: name
      end
      Group.new people: people
    end
    Event.new(groups: groups, name: name)
  end

  def create_event event
    event.save
    event
  end
end