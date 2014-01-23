class EventsUploader 
  def upload yaml
    create_event parse(yaml) 
  end

  def parse yaml
    values = YAML.load(yaml)
    name = values["name"]
    all_people = []
    groups = values["groups"].map do |group|
      people = group.map do |name|
        Person.find_by name: name
      end
      all_people << people
      Group.new people: people
    end
    event = Event.new(groups: groups, name: name)
    all_people.map {|p| event.add_person p}
    event
  end

  def create_event event
    event.save
    event
  end
end